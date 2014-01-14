class RemoveAttachmentFromEbook < ActiveRecord::Migration
  def change
    drop_attached_file :ebooks, :pdf
  end
end
