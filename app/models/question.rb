class Question < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks

  validates_presence_of :body
  validates_uniqueness_of :body, :case_sensitive => false

  def self.search(params)
    tire.search(load: true, page: params[:page], per_page: 10) do
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

      rows = CSV.open(file)
      #strict format skipping first two rows for header and space
      #rows.shift
      rows.shift
      rows.each do |row|

        index_map = { :body => 0 }

        question = Question.new

        question.body   = row[index_map[:body]]

        # p "++++ question import method"
        # p question.inspect
        # user.add_role "coach"
        question.save!

      end
    end

end