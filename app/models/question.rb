class Question < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks

  # index_name BONSAI_INDEX_NAME

  validates_presence_of :body
  validates_uniqueness_of :body, :case_sensitive => false

  scope :All, -> { where('last_import IS false') }
  scope :LastImported, -> { where('last_import IS true') }

  def self.search(params)
    tire.search(load: true, page: params[:page], per_page: 100) do
      query { string params[:query], default_operator: "AND" } if params[:query].present?
      # filter :term, :coach_role => true
      # sort { by :updated_at, "desc" }
    end
  end

  # def self.search(params)
  #   tire.search do
  #     query { string params[:query], default_operator: "AND" } if params[:query].present?
  #   end
  # end

  mapping do
    indexes :id, type: 'integer'
    indexes :body
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
        question.save!

      end
    end

end