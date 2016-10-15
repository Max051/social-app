class ConversationsController < ApplicationController
  before_action :logged_in_user
  helper_method :mailbox, :conversation

  def create
    recipient_name = conversation_params(:recipients).split(',')
    recipients = User.where(name: recipient_name).all
    conversation = current_user.
      send_message(recipients, *conversation_params(:body, :subject)).conversation

    conversation.participants.each do |notifier|
      if notifier.name != current_user.name
        @reciver = notifier
      end
    end
      @reciver.notify(@reciver.id,"You got a new message from #{current_user.name}")
    redirect_to conversation_path(conversation)
  end

  def reply
    current_user.reply_to_conversation(conversation, *message_params(:body, :subject))
    conversation.participants.each do |notifier|
      if notifier.name != current_user.name
        @reciver = notifier
      end
    end 
    if request.original_url != conversation_path(conversation)
      @reciver.notify(@reciver.id,"You got a new replay from #{current_user.name}")
    end

    redirect_to conversation_path(conversation)
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to :conversations
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to :conversations
  end

  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  def conversation_params(*keys)
    fetch_params(:conversation, *keys)
  end

  def message_params(*keys)
    fetch_params(:message, *keys)
  end

  def fetch_params(key, *subkeys)
    params[key].instance_eval do
      case subkeys.size
      when 0 then self
      when 1 then self[subkeys.first]
      else subkeys.map{|k| self[k] }
      end
    end
  end
end
