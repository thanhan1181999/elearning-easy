class Course < ApplicationRecord
  belongs_to :user
  belongs_to :course_category
  default_scope -> { order(created_at: :desc)}
  validates :user_id, presence: true
  validates :course_category_id, presence: true
  validates :name, presence: true, length: {maximum:400}
end
