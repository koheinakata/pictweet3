class TweetsController < ApplicationController

  before_action :move_to_index, except: :index

  def index                          # トップ画面
    # @tweets = Tweet.all.order("id DESC").page(params[:page]).per(5)
    @tweets = Tweet.all.includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end

  def new                           # 投稿画面

  end

  def create                        # 投稿の保存処理と保存完了画面
    Tweet.create(image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id)
  end

  # createメソッドの引数の中身をtweet_paramsに変えても同じように動く
  # def create
  #   Tweet.create(tweet_params)
  # end

#[ビュー]index.html.erb → [コントローラー]delete 'tweets/:id'
  def destroy                          # 投稿の削除と削除完了画面
    tweet = Tweet.find(params[:id])            #idはcurrent_user.idが入っている
    tweet.destroy if current_user.id == tweet.user_id
  end
#[ビュー]index.html.erb → [コントローラー]get 'tweets/:id/edit'
  def edit                          # 投稿の編集画面
    @tweet = Tweet.find(params[:id])
  end

#[ビュー]edit.html.erb → [コントローラー]patch 'tweets/:id'
  def update                       # 投稿の編集処理と編集完了画面
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params) if current_user.id == tweet.user_id
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments.includes(:user)
  end

  private
  # このメソッドの返り値は変数paramsである。つまりハッシュである。
  def tweet_params
    params.permit(:image, :text)
  end

  # createメソッドの引数の数を一つにしないとエラーがでるためmergeメソッドを使っている。
  # def tweet_params
  #   params.permit(:image, :text).merge(user_id: current_user.id)
  # end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end

# index       #投稿の採取と一覧表示
# show        #投稿の採取と一件表示
# new         # なしと新規投稿画面
# create      # 新規データの保存処理と保存完了画面
# edit        # 投稿の採取と編集画面
# update      # 投稿の編集処理と編集完了画面
# destroy     # 投稿の削除と削除完了画面

