class AddAttachmentAvatarToVirtualHubs < ActiveRecord::Migration
  def self.up
    change_table :virtual_hubs do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :virtual_hubs, :avatar
  end
end
