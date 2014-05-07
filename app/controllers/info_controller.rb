class InfoController < ApplicationController
  def index
  end

  def about
  end

  def features
  end

  def contact
  	
  end
  def send_message
  	p "in send_message ================================="
  	p params[:info][:subject]
  	p "2222================"
  	# params[subject:]
  	# @goal.deliver_email(current_user, "New Goal Created") if params[:is_send_email]
  	to_email = "ijmalik@gmail.com"
  	Resque.enqueue(MessageSendWorker, params[:info][:name], params[:info][:email],params[:info][:subject], params[:info][:message], to_email)

  	redirect_to info_contact_path, flash: {message: "Message Successfully Sent"}
  end
end
