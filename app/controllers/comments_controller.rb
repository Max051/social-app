class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @comment = current_user.comments.build(comments_params)
    @comment.user_id = current_user.id
    @micropost = Micropost.find(comments_params[:micropost_id])
    @reciver = User.find(@micropost.user_id)
    if @comment.save
      flash[:success] = "Comment created!"
      if @reciver != current_user
        @reciver.notify(@reciver.id,"#{current_user.name} commented your post")
      end
      respond_to do |format|
        format.html { redirect_to root_url }
        format.js {render inline: "location.reload();"}
      end
    else
      flash[:danger] = "Can't create"
     redirect_to root_url
    end
  end
  def destroy
   @comment.destroy
   flash[:success] = "Comment deleted"
    redirect_to request.referrer || root_url
  end
  private
  def comments_params
    params.require(:comment).permit(:content,:micropost_id)
  end
end
