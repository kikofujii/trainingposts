class Trainingpost < ApplicationRecord
  belongs_to :user
  validates :title, length: { maximum: 50}
  validates :content, presence: true, length: { maximum: 255 }
  
  
  mount_uploaders :post_img, ImgUploader
  has_many :favorites
  has_many :fovorite_user, through: :fovorites, source: :user
end
