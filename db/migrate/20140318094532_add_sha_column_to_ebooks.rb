class AddShaColumnToEbooks < ActiveRecord::Migration
  def change
    add_column :ebooks, :sha, :string
    Ebook.all.each do |ebook|
      if ebook.pdf.url
        ebook.update_column(:sha, create_pages(ebook.pdf))
      end
    end
  end

  private

  def self.create_pages(pdf)
    require 'open-uri'
    io = open(pdf.url)
    reader = PDF::Reader.new(io)
    Digest::SHA1.hexdigest(reader.pages.first.text)
  end
end

