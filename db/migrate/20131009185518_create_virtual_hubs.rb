class CreateVirtualHubs < ActiveRecord::Migration
  def change
    create_table :virtual_hubs do |t|
      t.string :name

      t.timestamps
    end

    add_index :virtual_hubs, :name, :unique => true
  end
end
