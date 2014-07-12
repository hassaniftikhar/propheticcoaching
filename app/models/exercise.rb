class Exercise < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks

  # index_name BONSAI_INDEX_NAME

  validates_presence_of :body
  validates_uniqueness_of :body, :case_sensitive => false
  
  has_many :exercise_categorizations
  has_many :categories, through: :exercise_categorizations, :class_name => "Category",
        :foreign_key => 'exercise_id'

  before_destroy :remove_es_index
  before_destroy {|exercise| exercise.categories.clear}

  # scope :All, -> { where('last_import IS false') }
  scope :All, -> { order('updated_at') }
  scope :LastImported, -> { where('last_import IS true') }

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
      end
    end
  end

  mapping do
    indexes :id, type: 'integer'
    indexes :body, type: 'string', boost: 10, analyzer: 'snowball'
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

  def self.import_csv(file)
      require "csv"

      Exercise.all.where(:last_import => true).each{|exercise| exercise.last_import=false; exercise.save! }

      rows = CSV.open(file)
      rows.shift
      rows.each do |row|

        index_map = { :body => 0 }

        exercise = Exercise.new

        exercise.body         = row[index_map[:body]]
        exercise.last_import  = true

        begin
          exercise.save!
        rescue ActiveRecord::RecordInvalid => e
          p "============ "+e.message
        end
      end
    end

end