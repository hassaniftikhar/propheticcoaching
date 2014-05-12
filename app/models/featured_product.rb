class FeaturedProduct < ActiveRecord::Base

  # has_one :ebook
  validates_presence_of :title
  validates_presence_of :image
  validates_presence_of :price
  validates_uniqueness_of :title, :case_sensitive => false
  # validates_uniqueness_of :sha
  # validate :is_book_unique
  # validates_uniqueness_of :sha

  mount_uploader :image, ImageUploader
  process_in_background :image

  belongs_to :profile, :polymorphic => true
end