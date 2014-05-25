class ContactRequest < ActiveRecord::Base

	validates_presence_of :subject, :first_name, :last_name, :email, :phone_no, :contact_mode, :city, :website, :heard_mode, :purpose, :message
 # Pending state_country
 
end
