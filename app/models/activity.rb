class Activity < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks
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

  before_destroy {|activity| activity.categories.clear}


  # scope :All, -> { where('last_import IS false') }
  scope :All, -> { order('updated_at') }
  scope :LastImported, -> { where('last_import IS true') }

  def self.search(params)
    tire.search(load: true, page: params[:page], per_page: 100) do
      query { string params[:query], default_operator: "AND" } if params[:query].present?
    end
  end

  mapping do
    indexes :id, type: 'integer'
    indexes :body
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