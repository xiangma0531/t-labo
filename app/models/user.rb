class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :grade
  belongs_to :subject
  belongs_to :course
  has_many :sources
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :favorites, through: :likes, source: :source
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  def own?(object)
    id == object.user_id
  end

  def already_liked?(source)
    favorites.include?(source)
  end

  def follow(other_user)
    if self != other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
end
