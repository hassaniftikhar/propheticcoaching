class BestFeature < ActiveRecord::Base

	mount_uploader :image, ImageUploader
	process_in_background :image

	 validates_presence_of :name
  validates_presence_of :pdf
  validates_uniqueness_of :name, :case_sensitive => false

end
