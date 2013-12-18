class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address
      t.string :home_phone
      t.string :availablity_time
      t.string :best_time_to_call
      t.datetime :date_of_birth

      t.timestamps
    end
  end
end
