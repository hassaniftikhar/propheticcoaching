class CreateBenefits < ActiveRecord::Migration
  def change
    create_table :benefits do |t|
      t.string :title

      t.timestamps
    end
  end
end
