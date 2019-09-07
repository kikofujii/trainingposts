class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: {maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                      uniqueness: { case_sensitive: false }
    validates :introduce, length: { maximum: 255 }
    has_secure_password
    
    mount_uploader :icon_img, ImgUploader
    has_many :trainingposts
    has_many :relationships
    has_many :followings, through: :relationships, source: :follow
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
    has_many :followers, through: :reverses_of_relationship, source: :user
    has_many :favorites
    has_many :favorite_trainingpost, through: :favorites, source: :trainingpost
    
    def follow(other_user)
        unless self == other_user
            self.relationships.find_or_create_by(follow_id: other_user.id)
        end
    end
    
    def unfollow(other_user)
        relationship = self.relationships.find_by(follow_id: other_user.id)
        relationship.destroy if relationship
    end
    
    def following?(other_user)
        self.followings.include?(other_user)
    end
    
    def like(trainingpost)
        self.favorites.find_or_create_by(trainingpost_id: trainingpost.id)
    end
    
    def unlike(trainingpost)
        favorite = self.favorites.find_by(trainingpost_id: trainingpost.id)
        favorite.destroy if favorite
    end    
    
    def liking?(trainingpost)
        self.favorite_trainingpost.include?(trainingpost)
    end
end
