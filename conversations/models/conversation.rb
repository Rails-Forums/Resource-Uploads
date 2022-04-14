class Conversation < ApplicationRecord
  establish_connection(:users)
  belongs_to :sender, class_name: "User", foreign_key: "sender_id", dependent: :destroy
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id", dependent: :destroy
  has_many :messages, dependent: :delete_all

  validates_uniqueness_of :sender_id, scope: :receiver_id

  scope :between, -> (sender_id, receiver_id) do
    where("(conversations.sender_id = ? AND conversations.receiver_id = ?) OR (conversations.receiver_id = ? AND conversations.sender_id = ?)", sender_id, receiver_id, sender_id, receiver_id)
  end
  scope :of_followed_users, -> (following_users) { where user_id: following_users }


  def recipient(current_user)
    self.sender_id == current_user.id ? self.receiver : self.sender
  end

  def unread_message_count(current_user)
    self.messages.where("user_id != ? AND read = ?", current_user.id, false).count
  end
end
