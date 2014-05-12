class Ebook < ActiveRecord::Base

  has_many :pages, dependent: :destroy
  validates_presence_of :name
  validates_presence_of :pdf
  validates_uniqueness_of :name, :case_sensitive => false
  # validates_uniqueness_of :sha
  # validate :is_book_unique
  # validates_uniqueness_of :sha

  mount_uploader :pdf, PdfUploader
  process_in_background :pdf

  has_one :featured_product, :as => :profile


  # after_save :update_sha
  # after_save :calculate_sha
  after_save :create_pages
  before_destroy :remove_es_index

  include Tire::Model::Search
  include Tire::Model::Callbacks

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
    Resque.enqueue(CreatePagesWorker, self.id)
  end

end