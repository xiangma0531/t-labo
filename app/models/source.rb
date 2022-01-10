class Source < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many_attached :images
  validates :images, length: {maximum: 10, message: "は10枚以下にしてください"}
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :grade
  belongs_to :subject
  belongs_to :course

  with_options presence: true do
    validates :title
    validates :grade_id
    validates :subject_id
    validates :course_id
    validates :content, unless: :was_attached?
  end

  def was_attached?
    self.images.attached?
  end
end