class AddAttachmentPhotoToMicropost < ActiveRecord::Migration
  def self.up
    change_table :microposts do |t|
      t.attachment :photoclip
    end
  end

  def self.down
    remove_attachment :microposts, :photoclip
  end
end
