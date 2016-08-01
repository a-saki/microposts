class Micropost < ActiveRecord::Base
  belongs_to :user
  has_many :favorites
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  # 画像のアップローダー
  mount_uploader :image, ImageUploader
end
