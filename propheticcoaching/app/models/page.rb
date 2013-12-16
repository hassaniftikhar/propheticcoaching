class Page < ActiveRecord::Base

  belongs_to :ebook
  before_destroy :remove_es_index

  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do
    indexes :id, type: 'integer'
    indexes :ebook_id, type: 'integer'
    indexes :page_number
    indexes :tags
  end

  def self.search(params)
    tire.search do
      query { string params[:query], default_operator: "AND" } if params[:query].present?
      sort { by :page_number, 'asc' }
    end
  end

  def remove_es_index
    puts "=== Page: removing es index"
    self.index.remove self
  end

  def to_indexed_json
    to_json(methods: [:ebook_name])
  end

  def ebook_name
    ebook.name
  end

end
