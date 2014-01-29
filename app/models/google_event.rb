
class GoogleEvent < ActiveRecord::Base
  belongs_to :profile, :polymorphic => true
  validate :eventAddress
  

  def eventAddress
    errors.add(:url, "this is not a valid url") unless url_valid?(url)
  end

  def url_valid?(url)
    url = URI.parse(url) rescue false
    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
  end

end
