class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #paginates_per 4
  accepts_nested_attributes_for :roles

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #has_many :mentees, :foreign_key => "coach_id"
  #has_and_belongs_to_many :mentees 
  has_and_belongs_to_many :mentees,
        :foreign_key => 'coach_id',
        :association_foreign_key => 'mentee_id',
        :class_name => 'Mentee',
        :join_table => 'coaches_mentees_joins'  

# has_and_belongs_to_many :clients,
#         :foreign_key => 'client_id',
#         :association_foreign_key => 'coach_id',
#         :class_name => 'User',
#         :join_table => 'coaches_clients
  has_many :chats
  has_many :events, :as => :profile
  has_many :google_events, :as => :profile

  scope :coach, -> { Role.where("name='coach'").first.users }


  def is_admin?
    self.has_role?(:admin) ? true : false
  end

  def name
    "#{first_name} #{last_name}".titleize
  end

  def escaped_name
    name.gsub /\W/, "_"
  end

def self.import_csv(file)
    require "csv"

    rows = CSV.open(file)
    #strict format skipping first two rows for header and space
    #rows.shift
    rows.shift
    rows.each do |row|

      index_map = { :first_name => 0, :last_name => 1, :email => 2, :address => 3,
                    :home_phone => 4, :password => 5 }

      user = User.new

      user.first_name   = row[index_map[:first_name]]
      user.last_name    = row[index_map[:last_name]]
      user.email        = row[index_map[:email]]
      user.address      = row[index_map[:address]]
      user.home_phone   = row[index_map[:home_phone]]
      user.password     = row[index_map[:password]]

      p "++++ user import method"
      p user.inspect
      user.add_role "coach"
      user.save!

    end
  end

end
