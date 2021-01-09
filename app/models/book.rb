class Book < ApplicationRecord
 belongs_to :user

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}


	 # book LIKEと書くことでbopkカラムを検索
  def self.search_for(content, method)
    if method == 'perfect' # 選択した検索方法がが完全一致だったら
      Book.where(title: content)
    elsif method == 'forward'# 選択した検索方法がが前方一致だったら
      Book.where('title LIKE ?', content+'%')
    elsif method == 'backward'# 選択した検索方法がが後方一致だったら
      Book.where('title LIKE ?', '%'+content)
    else # 選択した検索方法がが部分一致だったら
      Book.where('title LIKE ?', '%'+content+'%')
    end
  end
end
