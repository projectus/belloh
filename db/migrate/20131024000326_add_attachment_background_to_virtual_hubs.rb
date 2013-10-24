class AddAttachmentBackgroundToVirtualHubs < ActiveRecord::Migration
  def self.up
    change_table :virtual_hubs do |t|
      t.attachment :background
    end
  end

  def self.down
    drop_attached_file :virtual_hubs, :background
  end
end
