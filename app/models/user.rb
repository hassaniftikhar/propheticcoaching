class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #paginates_per 4
  accepts_nested_attributes_for :roles

  # index_name BONSAI_INDEX_NAME

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :coach_mentee_relations, :class_name => "CoachMenteeRelation",
        :foreign_key => 'coach_id'
  has_many :mentees, through: :coach_mentee_relations, :class_name => "Mentee",
        :foreign_key => 'coach_id'
  # has_and_belongs_to_many :mentees,
  #       :foreign_key => 'coach_id',
  #       :association_foreign_key => 'mentee_id',
  #       :class_name => 'Mentee',
  #       :join_table => 'coaches_mentees'  

  has_many :chats
  has_many :events, :as => :profile
  has_many :google_events, :as => :profile

  scope :coach, -> { Role.where("name='coach'").first.users }

  include Tire::Model::Search
  include Tire::Model::Callbacks

  def self.search(params)
    tire.search(load: true, page: params[:page], per_page: 10) do
      query { string params[:query], default_operator: "AND" } if params[:query].present?
      # filter :range, created_at: {lte: Time.zone.now-30.days}
      # filter :range, first_name: {lte: "a"}
      # filter :query, coach_role: {lte: "a"}
      filter :term, :coach_role => true
      sort { by :first_name, "asc" }
    end
  end

  mapping do
    indexes :id, type: 'integer'
    indexes :first_name
    indexes :last_name
    indexes :email
    indexes :address
    indexes :home_phone
    indexes :availablity_time
    indexes :best_time_to_call
    indexes :date_of_birth
    indexes :mentee_count
    indexes :coach_role
    # indexes :mentee_name
  end

  def to_indexed_json
    to_json(methods: [:mentee_count, :coach_role])
  end
    
  def mentee_count
    mentees.size
  end

  def coach_role
    roles_name.include? "coach"
  end
   #------------------------------------------------------------------------
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
      # user.save!

      begin
        user.save!
      rescue ActiveRecord::RecordInvalid => e
        # if e.message == 'Validation failed: User already been taken'
          # p  " ===============" + e.message
        # else
        #   p "else Validation failed: Already been taken ==============="
        #   p e.message
        #   p "================================="
        # end
        p  " ===============" + e.message
      end


    end
  end

end
