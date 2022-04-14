class MessagesController < ApplicationController
  before_action :sitedisable_check
  before_action :authenticate_user!

  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end
  before_action :check_convo_user

  def index
    @page_title = "Messages Lion social"
    @messages = @conversation.messages

    @messages.where("user_id != ? AND read = ?", current_user.id, false).update_all(read: true)

    @message = @conversation.messages.new
    @messages = @messages.by_newest
    @conversations = Conversation.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
  end

  def create
    @message = @conversation.messages.new(message_params)
    @message.user = current_user
    respond_to do |format|
      if @message.save
        format.html { redirect_to conversation_messages_url(@conversation)}
        format.json { render :index, status: :created, location: conversation_messages_url(@conversation) }
      end
    end
  end

  private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end
end
