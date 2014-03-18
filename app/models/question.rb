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
end