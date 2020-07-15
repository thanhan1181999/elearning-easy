class Lesson < ApplicationRecord
  belongs_to :course
  default_scope -> { order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :course_id, presence: true
  validates :name, presence: true
end
