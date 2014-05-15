class BestFeature < ActiveRecord::Base

	mount_uploader :image, ImageUploader
	process_in_background :image

	 validates_presence_of :title
  validates_presence_of :image
  validates_uniqueness_of :title, :case_sensitive => false

  mount_uploader :image, ImageUploader
  process_in_background :image

end
