class AddAdminToVirtualHub < ActiveRecord::Migration
  def change
    add_column :virtual_hubs, :admin_id, :integer
    add_index  :virtual_hubs, :admin_id
  end
end
