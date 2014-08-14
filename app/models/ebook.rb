class Ebook < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessor :category_id
  has_many :pages, dependent: :destroy
  # validates_presence_of :name
  validates_presence_of :name, :pdf
  validates_uniqueness_of :name, :case_sensitive => false
  # validates_uniqueness_of :sha
  # validate :is_book_unique
  # validates_uniqueness_of :sha

  mount_uploader :pdf, PdfUploader
  process_in_background :pdf

  # has_one :featured_product, :as => :profile
  has_many :ebook_categorizations
  has_many :categories, through: :ebook_categorizations, :class_name => "Category",
        :foreign_key => 'ebook_id'


  # after_save :update_sha
  # after_save :calculate_sha
  after_save :create_pages
  before_destroy :remove_es_index


  before_destroy {|ebook| ebook.categories.clear}

  
  after_save do
    tire.index.refresh
  end

  after_destroy do
    tire.index.refresh
  end


  # def get_sha
  #   require 'open-uri'
  #   sha = ''
  #   if self.pdf.path
  #     io = open(self.pdf.path)
  #     reader = PDF::Reader.new(io)
  #     book_text = ""
  #     reader.pages.each do |page|
  #       book_text = book_text + (page.text)
  #     end
  #     # sha = Digest::SHA1.hexdigest(reader.pages[reader.pages.length/2].text)
  #     sha = Digest::SHA1.hexdigest(book_text)
  #   end
  #   sha
  # end

  # def calculate_sha
  #   # self.sha = get_sha
  #   Resque.enqueue(CreatePages, self.pdf.path, self)
  # end

  # def is_book_unique
  #   sha = self.sha || calculate_sha
  #   # sha = self.sha
  #   if Ebook.find_by sha: sha
  #     errors.add :name, "book already exist"
  #   end
  # end

  def self.search(params)
    if params[:category].present?
      params_categories = params[:category]
      categories_ary = params_categories.to_s.split(',')
      tire.search(load: true, page: params[:page], per_page: 100) do
        query { 
          string params[:query], default_operator: "AND"  if params[:query].present?
          categories_ary.each do |category|  
            match 'categories.name',  category
          end
        }
        sort { by :updated_at, "desc" }
      end
    else
      tire.search(load: true, page: params[:page], per_page: 100) do
        query { string params[:query], default_operator: "AND" } if params[:query].present?
        sort { by :updated_at, "desc" }
        size 1
      end
    end
  end

  mapping do
    indexes :id, type: 'integer'
    indexes :name, type: 'string', boost: 10, analyzer: 'snowball'
    indexes :updated_at, type: 'date'
     
    indexes :categories do
      indexes :name, type: 'string', analyzer: 'snowball'
    end
  end

  def to_indexed_json
    to_json( include: { categories: { only: [:name] } } )
  end

  def remove_es_index
    self.index.remove self
  end

  def create_pages
    #unless self.featured_product
    Resque.enqueue(CreatePagesWorker, self.id)
    #end
  end

end