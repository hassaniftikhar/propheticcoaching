class ChatsController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_chat, only: [:show, :edit, :update, :destroy]

  # GET /chats/new
  def new
    @chat = Chat.new
  end

  # POST /chats
  # POST /chats.json
  def create
    #user = User.find_by :id => chat_params[:user_id]
    @chat = current_user.chats.new chat_params[:chat]

    respond_to do |format|
      if @chat.save
        message = {message: @chat.message, user_name: current_user.name, dest: chat_params[:dest], src: chat_params[:src]}
        PrivatePub.publish_to("/chats/talk", :message => message.to_json)
        format.js {}
        #render :nothing => true
        #format.html { redirect_to @chat, notice: 'Chat was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @chat }
      else
        render :text => @chat.errors.full_messages.to_sentence, :status => 422
        #format.html { render action: 'new' }
        #format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  #def set_chat
  #  @chat = Chat.find(params[:id])
  #end

  # Never trust parameters from the scary internet, only allow the white list through.
  def chat_params
    params.permit(:dest, :src, :chat => [:message, :recipient_id])
  end
end
