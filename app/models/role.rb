class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true
  
  scopify

  #validates_presence_of :name


  def self.global_roles
    where("resource_id is null").find_or_create_by :name => "admin"
    where("resource_id is null").find_or_create_by :name => "coach"
    where("resource_id is null").find_or_create_by :name => "mentee"
    global
  end

end
