require 'test_helper'

class CommentTest < ActiveSupport::TestCase
def setup
  @user = users(:archer)
  @micropost = microposts(:orange)
  @comment = @user.comments.build(content: 'Nice',user_id: @user.id, micropost_id: @micropost.id )
end

test "should be valid" do
  assert @comment.valid?
end
test "content should be valid" do
  @comment.content = ''
  assert_not @comment.valid?
end
test "user_id should be valid" do
  @comment.user_id = nil
  assert_not @comment.valid?
end
test "micropost_id should be valid" do
  @comment.micropost_id = nil
  assert_not @comment.valid?
end
end
