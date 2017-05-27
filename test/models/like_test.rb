require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
  @user = users(:michael)
  @another_user = users(:archer)
  @micropost = microposts(:orange)
  @comment = comments(:comment_one)

  @like_on_comment = @user.likes.build( comment_id: @comment.id )
  @like_on_micropost = @user.likes.build( micropost_id: @micropost.id )
@like_on_micropost.save
@like_on_comment.save
  @another_like_on_comment = @user.likes.build(comment_id: @comment.id)
    @another_like_on_micropost = @user.likes.build( micropost_id: @micropost.id )
  end

  test "like on comment should be valid" do
    assert @like_on_comment.valid?
  end
  test "like on micropost should be valid" do
    assert @like_on_micropost.valid?
  end

test "micropost id should be present on like_on_micropost" do
@like_on_micropost.micropost_id = nil
assert_not @like_on_micropost.valid?
end

test "comment id should be present on like_on_comment" do
@like_on_comment.comment_id = nil
assert_not @like_on_comment.valid?
end
test "user id should be present on comment" do
  @like_on_comment.user_id = nil
  assert_not @like_on_comment.valid?
end
test "user id should be present on micropost" do
  @like_on_micropost.user_id = nil
  assert_not @like_on_micropost.valid?
end

test "only one like on comment per user" do
  assert_not @another_like_on_comment.valid?
end

test "only one like on micropost per user" do
  assert_not @another_like_on_micropost.valid?
end

test "comment might have many likes" do
  another_like_on_comment = @another_user.likes.build( comment_id: @comment.id )
  assert another_like_on_comment.valid?
end
test "micropost might have many likes" do
  another_like_on_micropost = @another_user.likes.build( micropost_id: @micropost.id )
  assert another_like_on_micropost.valid?
end
end
