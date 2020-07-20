class Course < ApplicationRecord
  belongs_to :user
  belongs_to :course_category
  has_many :lessons, dependent: :destroy
  has_many :joins, dependent: :destroy
  default_scope -> { order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :course_category_id, presence: true
  validates :name, presence: true
end
