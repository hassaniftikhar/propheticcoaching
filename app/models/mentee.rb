class Mentee < ActiveRecord::Base

  rolify
  resourcify
  has_paper_trail

  #belongs_to :coach, :class_name => "User", :foreign_key => "coach_id"
  #has_and_belongs_to_many :coaches, :class_name => "User" 
  has_and_belongs_to_many :coaches,
        :foreign_key => 'mentee_id',
        :association_foreign_key => 'coach_id',
        :class_name => 'User',
        :join_table => 'coaches_mentees_joins'

# has_and_belongs_to_many :coaches,
#         :foreign_key => 'coach_id',
#         :association_foreign_key => 'client_id',
#         :class_name => 'User',
#         :join_table => 'coaches_clients'

  has_many :goals
  has_many :comments, :as => :resource
  has_many :events, :as => :profile
  has_many :google_events, :as => :profile
  has_many :tasks
  has_many :accomplishments
  has_many :email_histories

  def self.import_csv(file)
    require "csv"

    rows = CSV.open(file)
    #strict format skipping first two rows for header and space
    rows.shift
    rows.shift
    rows.each do |row|

      #Donor Id	First Name	Last Name	Email 	Home Phone	Availability	Prophecy	BC
      #["D78201", "John", "Meadow", "Jmeadow67@hotmail.com", "2023477891", "Morning"]

      index_map = { :donor_id => 0, :first_name => 1, :last_name => 2, :email => 3,
                    :home_phone => 4,:availability => 5, :prophecy => 6, :bc => 7 }

      mentee = Mentee.new

      mentee.donor_id     = row[index_map[:donor_id]]
      mentee.first_name   = row[index_map[:first_name]]
      mentee.last_name    = row[index_map[:last_name]]
      mentee.email        = row[index_map[:email]]
      mentee.home_phone   = row[index_map[:home_phone]]
      mentee.availability = row[index_map[:availability]]
      mentee.prophecy     = row[index_map[:prophecy]]
      mentee.bc           = row[index_map[:bc]]

      p "++++ mentee import method"
      p mentee.inspect

      mentee.save!

    end
  end

  def name
    "#{first_name} #{last_name}".titleize
  end

end
