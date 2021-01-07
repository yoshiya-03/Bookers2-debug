class SearchController < ApplicationController
  
  before_action :authenticate_user!
  
  # 条件分岐はコントローラーに記述してもいいが、見にくいコードになってしまう（Fat Contlloer）+ 処理が遅くなる原因になりえる
  

	def search
		# 選択したmodelの値を@modelに代入。
		@model = params[:model]
		# 検索ワードを@contentに代入。
		@content = params[:content]
		# 選択した検索方法の値を@methodに代入。
		@method = params[:method]
		# @model, @content, @methodを代入した、
    # search_forを@recordsに代入。
    
    # 選択したモデルがuserだったら
		if @model == 'user'
			@records = User.search_for(@content, @method)
		else # 選択したモデルがbookだったら
			@records = Book.search_for(@content, @method)
		end
	end
end
