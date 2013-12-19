class AddStatusToUser < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.boolean :status, :default => false
    end
  end
end
