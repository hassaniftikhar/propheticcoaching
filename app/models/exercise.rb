class Exercise < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks

  # index_name BONSAI_INDEX_NAME

  validates_presence_of :body
  validates_uniqueness_of :body, :case_sensitive => false
  # has_and_belongs_to_many :categories

  # scope :All, -> { where('last_import IS false') }
  scope :All, -> { order('updated_at') }
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