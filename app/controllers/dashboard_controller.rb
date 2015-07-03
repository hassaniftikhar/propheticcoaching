class DashboardController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_calendar_properties
  # before_action :set_mentee_id  
  def index
    @latest_resources = Ebook.order("created_at desc").limit(5)
    @coach_events = @current_user.events.where("endtime >= ? and coach_mentee_relation_id is null", Time.now).order("starttime asc").page(params[:evnt]).per(5) if @current_user.events
    # Meeting, Session are event
    @coach_meetings = @current_user.events.where("endtime >= ? and coach_mentee_relation_id is not null", Time.now).order("starttime asc").page(params[:meet]).per(5)
    @user = @current_user
    @mentees = @user.mentees.page(params[:ment]).per(5)


    @data = {'id' => @current_user.id,
             'name' => @current_user.name,
             'avatar' => 'https://s3-us-west-2.amazonaws.com/propheticcoaching-test/uploads/featured_product/image/40/show_context_to_content.png',
             'expiration' => (Time.now.to_f*1000 + 60*60*1000).round} #milli second

    require 'json'
    @encoded_data = @data.to_json


    @blocksize = 16


    @secret = 'pGJw3J0IcOjtsNeMs4ATNMulpscgpKDf6PWoIUgxdcE5pJ4chdE8pdLrDNMyNsWg'
    @md5 = Digest::MD5.hexdigest(@secret)


    @key = @md5[0..15]
    @iv = @md5[16..32]
    @size =@encoded_data.length

    @length = (@size % @blocksize)
    @pad = @blocksize - @length

    @padc = @pad.chr

    @data_pad = @encoded_data + (@padc * @pad)

    cipher = OpenSSL::Cipher::Cipher.new("aes-128-cbc")
    cipher.encrypt
    cipher.key = @key
    cipher.iv = @iv
    encrypted = cipher.update(@data_pad)
    #encrypted << cipher.final
    @encryptedsession = encrypted.unpack('H*').last
  end
end
