class CreateContactRequests < ActiveRecord::Migration
  def change
    create_table :contact_requests do |t|
      t.string :subject
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_no
      t.string :contact_mode
      t.string :city
      t.string :state_country
      t.string :website
      t.string :heard_mode
      t.string :purpose
      t.text :message

      t.timestamps
    end
  end
end
