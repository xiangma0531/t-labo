class Source < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :grade
  belongs_to :subject
  belongs_to :course

  with_options presence: true do
    validates :title
    validates :grade_id
    validates :subject_id
    validates :course_id
    validates :content
  end
end