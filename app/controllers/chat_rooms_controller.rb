
class ChatRoomsController < ApplicationController
	 
	def index
		@chat_rooms = ChatRoom.all
	end

	def new 
		@chat_room =  ChatRoom.new
	end

	def create
		@chat_room = current_user.chat_rooms.build(chat_room_params)
		if @chat_room.save
			flash[:success] = 'Chat room added'
			redirect_to chat_rooms_path
		else
			render 'new'
		end
	end

	def show
		@chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
		@message = Message.new
	end

	def update
		respond_to do |format|
		  if @class_room.update(chat_room_params)
			format.html { redirect_to @chat_room, notice: 'Chat Room was successfully updated.' }
			format.json { render :show, status: :ok, location: @chat_room }
		  else
			format.html { render :edit }
			format.json { render json: @class_room.errors, status: :unprocessable_entity }
		  end
		end
	end

	private
	def chat_room_params
		params.require(:chat_room).permit(:title)
	end
end