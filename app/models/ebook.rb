class Ebook < ActiveRecord::Base

  has_many :pages, dependent: :destroy
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  validate is_book_unique
  # validates_uniqueness_of :sha

  mount_uploader :pdf, PdfUploader

  # after_save :update_sha
  before_save :calculate_sha
  after_save :create_pages
  before_destroy :remove_es_index

  include Tire::Model::Search
  include Tire::Model::Callbacks

  def calculate_sha
    require 'open-uri'
    if self.pdf.path
      io = open(self.pdf.path)
      reader = PDF::Reader.new(io)
      self.sha = Digest::SHA1.hexdigest(reader.pages.first.text)
    end
  end

  def is_book_unique
    errors.add :pdf, "book already exist" if Ebook.find_by sha: self.sha
  end

  def self.search(params)
    tire.search do
      query { string params[:query], default_operator: "AND" } if params[:query].present?
    end
  end

  mapping do
    indexes :id, type: 'integer'
    indexes :name
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

end