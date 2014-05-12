class InfoController < ApplicationController
  def index
    @benefits = Benefit.order("created_at desc").limit(10)
    @featured_products = FeaturedProduct.order("created_at desc").limit(20)
  end

  def about
  end

  def features
  end

  def contact
  	
  end
  def send_message
  	to_email = "ijmalik@gmail.com"
  	Resque.enqueue(MessageSendWorker, params[:info][:name], params[:info][:email],params[:info][:subject], params[:info][:message], to_email)

  	redirect_to info_contact_path, flash: {message: "Message Successfully Sent"}
  end
end
