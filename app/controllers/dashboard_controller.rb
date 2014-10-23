class DashboardController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_calendar_properties
  # before_action :set_mentee_id  
  def index
    @latest_resources = Ebook.order("created_at desc").limit(5)
    @coach_events 		= @current_user.events.where("coach_mentee_relation_id is null", Time.now).order("starttime asc").page(params[:evnt]).per(2) if @current_user.events
    @coach_meetings 	= @current_user.events.where("coach_mentee_relation_id is not null", Time.now).order("starttime asc").page(params[:meet]).per(5)
    @user 						= @current_user
    @mentees 					= @user.mentees.page(params[:ment]).per(5)



    # $data = array(
    #   'id' => 1,
    #   'name' => 'Custom Login',
    #   'avatar' => 'http://mydomain.com/avatar/1.png',
    #   'expiration' => round(microtime(true) * 1000) + 60*60*1000 // in millisecond
    #   );


    @data = {:id => @current_user.id,
      :name => @current_user.name,
      :avatar => 'http://mydomain.com/avatar/1.png' }


      # $data = json_encode($data);
      p "================Data"
      p @data

      @data.to_json
      require 'json'

      # $blocksize = 16;

      @blocksize = 32

      # $secret = '';
      # $md5 = md5($secret);

      @secret = ''
      @md5 = Digest::MD5.hexdigest(@secret)


      # $key = substr($md5, 0, 16);
      # $iv = substr($md5, 16, 16);

      @key = @md5[0..16]
      @iv = @md5[16..32]


      # $pad = $blocksize - (strlen($data) % $blocksize);


      @pad = @blocksize - (@data.length % @blocksize)

      #$data = $data . str_repeat(chr($pad), $pad);
      @data = @data.to_s + (@pad.to_s * @pad) 

      # $encryptedSession = bin2hex(mcrypt_encrypt(MCRYPT_RIJNDAEL_128, $key, $data, MCRYPT_MODE_CBC, $iv));

      cipher = OpenSSL::Cipher::Cipher.new("aes-128-cbc")
      cipher.encrypt
      cipher.key = @key
      cipher.iv = @iv
      encrypted = cipher.update(@data)    
      encrypted << cipher.final
      @encryptedSession = [encrypted].pack("H*")

    end
  end



