class ChatsController < ApplicationController
  def index
    @chats = Chat.all
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)
    respond_to do |format|
      # binding.pry
      if @chat.save
        format.html { redirect_to @chat, notice: 'Message was successfully posted.' }
        format.json { render :show, status: :created, location: @chat }
      else
        format.html { render :new }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @chat = Chat.new
  end

  def show
  end

  def auth
    if logged_in?
      response = Pusher.authenticate(params[:channel_name], params[:socket_id],
      {
        user_id: current_user.id, # => required
        user_info: { # => optional - for example
          name: current_user.name,
          email: current_user.email,
          image: avatar_url(current_user)
        }
      })
      render json: response
    else
      render text: 'Forbidden', status: '403'
    end
  end
  
  def chat_params
    params.require(:chat).permit(:username, :message)
  end

end
