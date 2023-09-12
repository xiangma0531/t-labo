class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  def yet_messages(user)
    self.messages.where(already: false).where.not(user_id: user.id).count
  end
end
