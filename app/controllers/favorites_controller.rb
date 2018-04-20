class FavoritesController < ApplicationController
  def create 
    favorite = current_user.favorites.create(post_id: params[:post_id])
	redirect_to posts_url, notice: "#{favorite.post.user.name}のやつ気に入った"
  end

  def destroy
    favorite = current_user.favorites.find_by(post_id: params[:post_id]).destroy
	redirect_to post_url, notice: "#{favorite.post.user.name}のやつお気に入りじゃなかったわ"
  end
end
