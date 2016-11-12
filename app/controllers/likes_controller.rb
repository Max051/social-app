class LikesController < ApplicationController
  def create
@like = current_user.likes.build(like_params)
if @like.save
redirect_to :back
else
  if Like.where("user_id= ? AND micropost_id = ? OR comment_id = ?",current_user.id,@like.micropost_id,@like.comment_id)

    Like.where("user_id= ? AND micropost_id = ? OR comment_id = ?",current_user.id,@like.micropost_id,@like.comment_id).destroy_all
redirect_to :back
  else
  flash[:danger] = "Something went wrong"
 redirect_to root_url
 end
end
  end
  private
  def like_params
    params.require(:like).permit(:micropost_id,:comment_id)
  end
end
