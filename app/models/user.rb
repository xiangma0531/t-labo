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
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :favorites, through: :likes, source: :source

  def own?(object)
    id == object.user_id
  end

  def already_liked?(source)
    favorites.include?(source)
  end
end
