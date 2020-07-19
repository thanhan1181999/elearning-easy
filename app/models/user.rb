class User < ApplicationRecord
    has_many :courses, dependent: :destroy
    has_many :studies, dependent: :destroy
    attr_accessor :remember_token, :activation_token
    mount_uploader :picture, PictureUploader
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    before_save {self.email = email.downcase } # hoặc sử dụng email.downcase!

    validates :name, presence: true, length: { maximum:50}
    validates :email, presence: true, length: { maximum:255}, 
                format: { with: VALID_EMAIL_REGEX},
                :uniqueness => {:case_sensitive => false}
    has_secure_password
    validates :password, presence: true, length: {minimum:6}, allow_blank: true

    def User.digest(string)
        cost =  cost = ActiveModel::SecurePassword.min_cost ? 
            BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # Remembers a user in the database for use in persistent sessions.
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Returns true if the given token matches the digest.
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # Forgets a user.
    def forget 
        update_attribute(:remember_digest, nil)
    end

end
