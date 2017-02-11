# rails g controller usersでできたファイル
#/users/#{comment.user_id}でshow.html.erbからリンクがとびget 'users/:id'   =>  'users#show'で実行される
class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @tweets = user.tweets.page(params[:page]).per(5).order("created_at DESC")
    #アソシエーションを組んでいない場合
    # @tweets = Tweet.where(user_id: current_user.id).page(params[:page]).per(5).order("created_at DESC")
  end
end
