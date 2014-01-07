class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  accepts_nested_attributes_for :roles

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :mentees, :foreign_key => "coach_id"
  has_many :chats

  scope :coaches, -> { Role.where("name='coach'").first.users }

  def is_admin?
    self.has_role?(:admin) ? true : false
  end

  def name
    "#{first_name} #{last_name}".titleize
  end

  def escaped_name
    name.gsub /\W/, "_"
  end

end
