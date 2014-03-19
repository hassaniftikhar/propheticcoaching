class AddShaColumnToEbooks < ActiveRecord::Migration
  def change
  		add_column :ebooks, :sha, :string
  		# Ebook.connection.execute("update ebooks set sha = self.create_pages")
				Ebook.all.each do |ebook|
    if ebook.pdf.url
						ebook.update_column(:sha, AddShaColumnToEbooks.create_pages(ebook.pdf))
				end
				end
  end

private

  def self.create_pages(pdf)
    # str = []
      require 'open-uri'
      io = open(pdf.url)
      reader = PDF::Reader.new(io)
						Digest::SHA1.hexdigest reader.pages.first.text
  end
end

