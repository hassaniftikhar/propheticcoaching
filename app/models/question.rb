class Question < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks

  # index_name BONSAI_INDEX_NAME
  attr_accessor :category_id

  validates_presence_of :body
  validates_uniqueness_of :body, :case_sensitive => false
  # has_and_belongs_to_many :categories
  has_many :question_categorizations
  has_many :categories, through: :question_categorizations, :class_name => "Category",
        :foreign_key => 'question_id'

  # after_touch() { tire.update_index }
  # self.include_root_in_json = false

  before_destroy :remove_es_index
  before_destroy {|question| question.categories.clear}
  # scope :All, -> { where('last_import IS false') }
  # scope :All
  scope :All, -> { order('updated_at') }
  # default_scope { order('updated_at') }
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
        # filter :term, :coach_role => true
        # sort { by :updated_at, "desc" }
      end
    end
  end

  # def self.search(params)
  #   tire.search do
  #     query { string params[:query], default_operator: "AND" } if params[:query].present?
  #   end
  # end

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

  # def to_indexed_json
  #   to_json(methods: [:question_count])
  # end
    
  # def question_count
  #   questions.size
  # end
  def self.import_csv(file)
      require "csv"

      Question.all.where(:last_import => true).each{|question| question.last_import=false; question.save! }

      rows = CSV.open(file)
      #strict format skipping first two rows for header and space
      #rows.shift
      rows.shift
      rows.each do |row|

        index_map = { :body => 0 }

        question = Question.new

        question.body         = row[index_map[:body]]
        question.last_import  = true

        # p "++++ question import method"
        # p question.inspect
        # user.add_role "coach"
        # question.save!

        begin
          question.save!
        rescue ActiveRecord::RecordInvalid => e
          p "============ "+e.message
          # if e.message == 'Validation failed: Body has already been taken'
          #   p  " ===============" + e.message
          # # else
          # #   p "else Validation failed: Already been taken ==============="
          # #   p e.message
          # #   p "================================="
          # end
        end
        # format.html { redirect_to(root_url, :notice => 'Subscription was successfully created.') }

      end
    end

end