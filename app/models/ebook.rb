class Ebook < ActiveRecord::Base

  has_many :pages, dependent: :destroy
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  mount_uploader :pdf, PdfUploader

  after_save :create_pages
  before_destroy :remove_es_index

  include Tire::Model::Search
  include Tire::Model::Callbacks

  def self.search(params)
    tire.search do
      query { string params[:query], default_operator: "AND" } if params[:query].present?
    end
  end

  #mapping _source: {excludes: ['attachment']} do
  mapping do
    indexes :id, type: 'integer'
    indexes :name
    #indexes :attachment, :type => 'attachment',
    #        :fields => {
    #            :name => {:store => 'yes'},
    #            :content => {:store => 'yes'},
    #            :title => {:store => 'yes'},
    #            :attachment => {:term_vector => 'with_positions_offsets', :store => 'yes'},
    #            :date => {:store => 'yes'}
    #        }
  end

  def remove_es_index
    self.index.remove self
  end

  def create_pages
    str = []
    if pdf.url
      require 'open-uri'
      io = open(pdf.url)
      reader = PDF::Reader.new(io)
      reader.pages.each_with_index do |page, index|
        self.pages.create! page_number: (index+1), tags: page.text
      end
    end
  end

  #def import_pages
  #  puts "===running import pages"
  #  str = []
  #  if pdf.path
  #    reader = PDF::Reader.new(pdf.path)
  #    reader.pages.each_with_index do |page, index|
  #      puts "===rendering page: #{page} - index: #{index}"
  #      str << { :id => index, :parent_id => self.id, :name => self.name, :created_at => self.created_at,
  #              :type => "ebook", :page => (index+1), :tags => page.text, :pdf_path => self.pdf.path,
  #              :pdf_url => self.pdf.url }
  #    end
  #  end
  #
  #  Tire.index "ebooks" do
  #    import str
  #  end
  #end

  #def attachment
  #  if pdf.path
  #    Base64.encode64(open(pdf.path) { |file| file.read })
  #  else
  #    Base64.encode64("missing")
  #  end
  #end

  #def to_indexed_json
  #  to_json(methods: [:attachment])
  #end

end