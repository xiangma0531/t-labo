class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :source
  validates :text, presence: true
end