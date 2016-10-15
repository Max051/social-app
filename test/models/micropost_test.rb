require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  @user = users(:michael)
  @micropost = @user.microposts.build(content:"Lorem ipsun", photoclip: File.new("app/assets/images/cover.jpg"))
  end
    test "should be valid" do
      assert @micropost.valid?
    end
    test "id should be present" do
      @micropost.user_id = nil
      assert_not @micropost.valid?
    end
    test "content should be present if photoclip is not" do
     @micropost.content = "   "
     @micropost.photoclip = nil
     assert_not @micropost.valid?
   end
   test "photoclip should be present if content is not" do
     @micropost.content = ""
     assert @micropost.valid?
   end
   test "content should be at most 140 characters" do
     @micropost.content = "a" * 141
     assert_not @micropost.valid?
   end
   test "photo must be file" do
     assert   @micropost.photoclip.file?
   end
   test "photo content must be valid" do
     @micropost.photoclip_content_type = 'video/mp4'
     assert_not  @micropost.valid?
   end
   test "photo cannot be too big" do
     @micropost.photoclip_file_size = 2000000
     assert_not @micropost.valid?
   end
   test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end



end
