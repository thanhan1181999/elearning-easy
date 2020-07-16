class Lesson < ApplicationRecord
  belongs_to :course
  has_and_belongs_to_many :words, dependent: :destroy
  default_scope -> { order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :course_id, presence: true
  validates :name, presence: true
  # validates :picture, presence: true
end
