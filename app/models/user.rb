class User < ApplicationRecord
    has_many :courses, dependent: :destroy
    has_many :studies, dependent: :destroy
    has_many :joins, dependent: :destroy


    #user have many active_relationships assosiation with table Relationship
    #(have many record like [this user id (follower_id), id of followed user id]) in table Relationship
    # following is collection representative for active_relationships assosiation
    # is collection of foll
    has_many :active_relationships, class_name: "Relationship",
        foreign_key: "follower_id", dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed

    has_many :passive_relationships, class_name:"Relationship",
        foreign_key: "followed_id", dependent: :destroy
    has_many :followers, through: :passive_relationships, source: :follower

    attr_accessor :remember_token, :activation_token
    before_save {self.email = email.downcase } # hoặc sử dụng email.downcase!
    before_create :create_activation_digest

    mount_uploader :picture, PictureUploader
    
    #authen social
    devise :omniauthable , omniauth_providers: [:facebook, :google_oauth2] 

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

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

    def create_activation_digest
        self.activation_token = User.new_token
        self.activation_digest = User.digest(activation_token)
    end

    # Returns true if the given token matches the digest.
    # def authenticated?(remember_token)
    #     return false if remember_digest.nil?
    #     BCrypt::Password.new(remember_digest).is_password?(remember_token)
    # end

    # Returns true if the given token matches the digest.
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil? 
        BCrypt::Password.new(digest).is_password?(token)
    end

    # Activates an account.
    def activate
        update_attribute(:activated, true)
        update_attribute(:activated_at, Time.zone.now)
    end

    # Sends activation email.
    def send_activation_email 
        UserMailer.account_activation(self).deliver_now
    end

    # Forgets a user.
    def forget 
        update_attribute(:remember_digest, nil)
    end

    # Follows a user.
    def follow(other_user) 
        active_relationships.create(followed_id: other_user.id)
    end
    # Unfollows a user.
    def unfollow(other_user)
        active_relationships.find_by(followed_id: other_user.id).destroy
    end
    # Returns true if the current user is following the other user.
    def following?(other_user) 
        following.include?(other_user)
    end

    def self.from_omniauth(auth)
        random = Devise.friendly_token[0,20]
        User.where(provider: auth.provider, uid: auth.uid).first_or_create(
            email: auth.info.email,
            password: random,
            password_confirmation: random,
            name: auth.info.name,
            uid: auth.uid,
            provider: auth.provider,
            image: auth.info.image,
            activated: true,
            activated_at: Time.zone.now)
    end

end
