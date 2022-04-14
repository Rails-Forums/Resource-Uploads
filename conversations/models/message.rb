class Message < ApplicationRecord
  establish_connection(:users)
  after_create_commit { broadcast_prepend_to "messages", target: self.conversation }

  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id, :user_id

  scope :by_newest, -> { self.order(created_at: :desc) }

  private
    def message_time
      created_at.strftime("%d/%m/%y at %l:%M %p")
    end
end
