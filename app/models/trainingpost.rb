class Trainingpost < ApplicationRecord
  belongs_to :user
  validates :title, length: { maximum: 50}
  validates :content, presence: true, length: { maximum: 255 }
  validates :training_part, presence: true
  
  
  mount_uploader :post_img, ImgUploader
  has_many :favorites, dependent: :destroy
  has_many :fovorite_user, through: :fovorites, source: :user
  
  after_create :is_continuos_post
  
  def self.search(search)
    search ? where('content LIKE ? OR training_part LIKE ?', "%#{search}%", "%#{search}%") :all
  end
  
  private
  #連続投稿について記述
  def is_continuos_post
    d = Date.today
    yesterday = d - 1
    tyokuzen_trainingpost = self.user.trainingposts[-2]
    if tyokuzen_trainingpost
      continuos_post_at = tyokuzen_trainingpost.created_at.to_date
      if continuos_post_at == yesterday
        self.user.increment(:continuos_count, 1)
        self.user.save
      elsif continuos_post_at < yesterday
        self.user.continuos_count = 1
        self.user.save
      end
    else
      self.user.continuos_count = 1
      self.user.save
    end
  end
end
