class Activity < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks

  validates_presence_of :body
  validates_uniqueness_of :body, :case_sensitive => false

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