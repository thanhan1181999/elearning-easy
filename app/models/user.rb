class User < ApplicationRecord
    attr_accessor :activation_token

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    before_save {self.email = email.downcase } # hoặc sử dụng email.downcase!

    validates :name, presence: true, length: { maximum:50}
    validates :email, presence: true, length: { maximum:255}, 
                format: { with: VALID_EMAIL_REGEX},
                :uniqueness => {:case_sensitive => false}
    has_secure_password
    validates :password, presence: true, length: {minimum:6}

end
