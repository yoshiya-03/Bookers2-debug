class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books
  attachment :profile_image, destroy: false
  
 # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  
  # name LIKEと書くことでnameカラムを検索
  def self.search_for(content, method)
    if method == 'perfect'  # 選択した検索方法がが完全一致だったら
      User.where(name: content)
    elsif method == 'forward' # 選択した検索方法がが前方一致だったら
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward' # 選択した検索方法がが後方一致だったら
      User.where('name LIKE ?', '%' + content)
    else      # 選択した検索方法がが部分一致だったら
      User.where('name LIKE ?', '%' + content + '%') 
    end
  end
  
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
end



