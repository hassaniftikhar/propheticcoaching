class BestFeature < ActiveRecord::Base

	mount_uploader :image, ImageUploader
	process_in_background :image

	validates_presence_of :title
 validates :title, length: { maximum: 26,
    too_long: "%{count} characters is the maximum allowed" }	
 validates_presence_of :image
 validates_uniqueness_of :title, :case_sensitive => false
 # validates_length_of :title, :minimum => 5, :maximum => 30, :allow_blank => false
end
