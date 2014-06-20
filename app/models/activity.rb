class Activity < ActiveRecord::Base

  
  

  attr_accessor :category_id
  
  validates_presence_of :body
  validates_uniqueness_of :body, :case_sensitive => false
  has_many :comments, :as => :resource
  # has_and_belongs_to_many :categories
  # has_and_belongs_to_many :categories,
  #       :foreign_key => 'activity_id',
  #       :association_foreign_key => 'category_id',
  #       :class_name => 'Category',
  #       :join_table => 'activities_categories'  
  has_many :activity_categorizations
  has_many :categories, through: :activity_categorizations, :class_name => "Category",
        :foreign_key => 'activity_id'

  # after_touch() { tire.update_index }
  self.include_root_in_json = false
  include Tire::Model::Search
  include Tire::Model::Callbacks


  before_destroy {|activity| activity.categories.clear}


  # scope :All, -> { where('last_import IS false') }
  # default_scope order('updated_at DESC')
  scope :All, -> { order('updated_at DESC') }
  scope :LastImported, -> { where('last_import IS true') }

  # before_filter :category_filter

  # def category_filter
  #   if(self.activity_categorizations.pluck(:category_id).include? params[:category].to_i)
      
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


  def self.import_csv(file)
      require "csv"

      Activity.all.where(:last_import => true).each{|activity| activity.last_import=false; activity.save! }

      rows = CSV.open(file)
      #strict format skipping first two rows for header and space
      #rows.shift
      rows.shift
      rows.each do |row|

        index_map = { :body => 0 }

        activity = Activity.new

        activity.body         = row[index_map[:body]]
        activity.last_import  = true

        begin
          activity.save!
        rescue ActiveRecord::RecordInvalid => e
          p "============ "+e.message
        end
      end
    end
end