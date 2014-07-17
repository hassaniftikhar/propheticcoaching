class EbookCategorization < ActiveRecord::Base

  belongs_to :category
  belongs_to :ebook

		after_save do
			self.ebook.pages.each do |page| page.tire.update_index end
  end
end
