class AddAttachmentPdfToEbooks < ActiveRecord::Migration
  def self.up
    change_table :ebooks do |t|
      t.attachment :pdf
    end
  end

  def self.down
    drop_attached_file :ebooks, :pdf
  end
end
