class EbookCategorization < ActiveRecord::Base

  belongs_to :category
  belongs_to :ebook
end
