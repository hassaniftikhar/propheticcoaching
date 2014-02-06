# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ebook do
    name "test book"
    pdf Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/test.pdf')))
  end
end
