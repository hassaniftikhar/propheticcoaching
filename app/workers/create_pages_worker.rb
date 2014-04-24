class CreatePagesWorker
  @queue = :generic_queue
  def self.perform(ebook_id)
    ebook = Ebook.find_by(id: ebook_id)
    if ebook.pdf.url
      require 'open-uri'
      io = open(ebook.pdf.url)
      reader = PDF::Reader.new(io)
      reader.pages.each_with_index do |page, index|
        ebook.pages.create! page_number: (index+1), tags: page.text
      end
    end


  #   require 'open-uri'
  #   sha = ''
  #   if pdf_path
  #     io = open(pdf_path)
  #     reader = PDF::Reader.new(io)
  #     book_text = ""

  #     reader.pages.each_with_index do |page, index|
  #       # self.pages.create! page_number: (index+1), tags: page.text
  #       book_text = book_text + (page.text)
  #     end      
  #     ebook[:sha] = Digest::SHA1.hexdigest(book_text)
  #     # ebook.save
  #       p "=================================== ebook Worker"
  #       p ebook
  #     p ebook[:sha]
  #       p "===================================in  Worker"
  #   end
  #   p sha
	end
end
