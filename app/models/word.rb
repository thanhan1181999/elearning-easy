class Word < ApplicationRecord
    has_and_belongs_to_many :lessons
    has_many :studies, dependent: :destroy
    
    validates :word, presence: true, length: { maximum:50}
    validates :meaning, presence: true
    mount_uploader :picture, PictureUploader
end
