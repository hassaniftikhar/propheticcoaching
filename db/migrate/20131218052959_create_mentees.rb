class CreateMentees < ActiveRecord::Migration
  def change
    create_table :mentees do |t|
      t.string :donor_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :home_phone
      t.string :availability
      t.text :prophecy
      t.string :bc

      t.timestamps
    end
  end
end
