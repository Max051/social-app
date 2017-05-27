class Micropost < ActiveRecord::Base
  attr_accessor :photoclip
  belongs_to :user
  has_attached_file :photoclip, :styles => { :large => "500x400>", :medium => "100x80>" }
  validates_attachment :photoclip,
    content_type: { content_type: ["image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..1.megabytes },
    file_name: {matches: [/png\Z/, /jpe?g\Z/, /gif\Z/]}

  validates :user_id, presence: true
  validates :content, length: { maximum: 140 }
  default_scope -> {order(created_at: :desc)}

  validates_presence_of :content, :unless => :photoclip?
  has_many :comments
  has_many :likes
  def comments_feed
    @comments_feed = Comment.where(micropost_id: self.id)
  end
end
