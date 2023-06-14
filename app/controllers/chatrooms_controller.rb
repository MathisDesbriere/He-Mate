class ChatroomsController < ApplicationController
  def index
    @chatrooms = policy_scope(Chatroom)
    @messages = policy_scope(Message)
    @last_message = @messages.order(created_at: :desc).where(chatroom: @chatroom).last
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    authorize @chatroom
  end

  def create
    creator = User.find(chatroom_params[:creator])
    participant = User.find(chatroom_params[:participant])

    @existing_chatroom = Chatroom.find_by(
      creator: creator, participant: participant
    ) || Chatroom.find_by(
      creator: participant, participant: creator
    )

    if @existing_chatroom
      authorize @existing_chatroom
      redirect_to chatroom_path(@existing_chatroom)
    else
      @chatroom = Chatroom.new(chatroom_params)
      @chatroom.creator = creator
      @chatroom.participant = participant

      authorize @chatroom

      if @chatroom.save
        redirect_to chatroom_path(@chatroom)
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:creator, :participant)
  end
end
