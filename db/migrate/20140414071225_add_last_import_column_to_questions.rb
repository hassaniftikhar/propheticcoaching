class AddLastImportColumnToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :last_import, :boolean, :default => false
  end
end
