
class GoogleEvent < ActiveRecord::Base
  belongs_to :profile, :polymorphic => true
  #validates :url, :eventAddress
  validate :eventAddress
  def eventAddress
  		URI.parse(url)

    # begin
    #   URI.parse(url)
    # rescue 
    # 		p URI::InvalidURIError
    # 		return false
    #end
		end
end
