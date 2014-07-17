class InfoController < ApplicationController
  def index
    @benefits = Benefit.order("updated_at desc").limit(10)
    @featured_products = FeaturedProduct.order("updated_at desc").limit(20)
    @best_features = BestFeature.order("updated_at desc").limit(4)
    # @video_path = '<iframe src="//player.vimeo.com/video/100508776" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>'.html_safe
    @video_path = Video.order("updated_at desc").first.path.html_safe
  end

  def about
  end

  def features
  end

  # def send_message
  # 	to_email = "ijmalik@gmail.com"
  # 	Resque.enqueue(MessageSendWorker, params[:info][:name], params[:info][:email],params[:info][:subject], params[:info][:message], to_email)

  # 	redirect_to info_contact_path, flash: {message: "Message Successfully Sent"}
  # end
end
