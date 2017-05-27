class Like < ActiveRecord::Base
  belongs_to :micropost
  belongs_to :comment
  belongs_to :user

    validates :user_id, presence: true


  validates_presence_of :micropost_id, :unless => :comment_id?
  validates_presence_of :comment_id, :unless => :micropost_id?

  validates_uniqueness_of :micropost_id, scope: :user_id, :unless => :comment_id?
  validates_uniqueness_of :comment_id, scope: :user_id, :unless => :micropost_id?
end
