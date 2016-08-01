class User < ActiveRecord::Base
    before_save { self.email = self.email.downcase}
    validates :name, presence: true, length: {maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
    has_secure_password
    
    validates :introduce, length: {maximum: 255}, allow_blank: true
    validates :homepage, allow_blank: true, format: /\A#{URI::regexp(%w(http https))}\z/, length: {maximum: 255}
    validates :location, allow_blank: true,  length: {maximum: 255}
    
    has_many :microposts
    
    has_many :following_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
    has_many :following_users, through: :following_relationships, source: :followed
    
    has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
    has_many :follower_users, through: :follower_relationships, source: :follower
    

    
    #メソッドの追加
    #他のユーザーをフォローする
    def follow(other_user)
        following_relationships.find_or_create_by(followed_id: other_user.id)
    end
    
    #フォローしているユーザーのフォローを外す
    def unfollow(other_user)
        following_relationship = following_relationships.find_by(followed_id: other_user.id)
        following_relationship.destroy if following_relationship
    end
    
    #フォローしているかどうか
    def following?(other_user)
        following_users.include?(other_user)
    end
    
    #自分とフォローしてるユーザのつぶやきを取得
    def feed_items
        Micropost.where(user_id: following_user_ids + [self.id])
    end
    
    
    
    has_many :favorites
    has_many :favorite_id, through: :favorites, source: :micropost
    
    # お気に入り登録
    def register_favorite(other_post)
        favorites.find_or_create_by(micropost_id: other_post.id)
    end
    
    # お気に入り解除
    def destroy_favorite(other_post)
        favorite = favorites.find_by(micropost_id: other_post.id)
        favorite.destroy if favorite
    end
    
    def favoriting?(other_post)
        favorite_id.include?(other_post)
    end
    
end
