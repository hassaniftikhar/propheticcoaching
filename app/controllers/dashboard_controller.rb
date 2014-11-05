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



    # data = array(
    #   'id' => 1,
    #   'name' => 'Custom Login',
    #   'avatar' => 'http://mydomain.com/avatar/1.png',
    #   'expiration' => round(microtime(true) * 1000) + 60*60*1000 // in millisecond
    #   );


# data = {'id' => @current_user.id,
#   'name' => @current_user.name,
#   'avatar' => 'http://mydommmmmain.com/avatar/1.png',
#   'expiration' => 1414872473402 } #milli second


#       # $data = json_encode($data);

#       # require 'json'
#       @data = @data.to_json

#       # $blocksize = 16;how to pass parameter in call php script from

#       @blocksize = 16

#       # $secret = '';
#       # $md5 = md5($secret);

#       @secret = 'iai8s0lF39dUPRLnAClxbtPPnZGqKhclAmDotpVHQgH1iBTDXUm8Ov76ZD3CKLrS'
#       @md5 = Digest::MD5.hexdigest(@secret)


#       # $key = substr($md5, 0, 16);
#       # $iv = substr($md5, 16, 16);

#       @key = @md5[0..16]
#       @iv = @md5[16..32]
#       # $pad = $blocksize - (strlen($data) % $blocksize);

#       @size =@data.length


#       @length = (@size % @blocksize)
#       @pad = @blocksize - @length



#       #$data = $data . str_repeat(chr($pad), $pad);
#       @padc = @pad.chr
#       @data = @data + (@padc* @pad) 




#         # $encryptedSession = bin2hex(mcrypt_encrypt(MCRYPT_RIJNDAEL_128, $key, $data, MCRYPT_MODE_CBC, $iv));

#         cipher = OpenSSL::Cipher::Cipher.new("aes-128-cbc")
#         cipher.encrypt
#         cipher.key = @key
#         cipher.iv = @iv
#       #encrypted = []
#       encrypted = cipher.update(@data)    
#       encrypted << cipher.final



#       @encryptedSession = [encrypted].pack("H*")

      # @encryptedsession = 'de1486bd3f5e328052fcb11acc56149d73564d3ae1df73d9fad1a5bafb2d9065fc079cb6c3c70b20e898507154e4c3aac78000288a7bc0e93660beaf67d4c7ed98729f4532b2e6f1f098b81eff1550847219ca4867c44ba43607d58c70f13337af1e56720957aeb2a32d377b2cc1db02'

    

      php_output = `php example.php #{@current_user.id} #{@current_user.name}`

      code = php_output.gsub("\n",'')

      @encryptedsession = code

    end

  end



