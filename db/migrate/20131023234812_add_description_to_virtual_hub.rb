class AddDescriptionToVirtualHub < ActiveRecord::Migration
  def change
    add_column :virtual_hubs, :description, :text
  end
end
