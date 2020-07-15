class Study < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :lesson
  belongs_to :word
end
