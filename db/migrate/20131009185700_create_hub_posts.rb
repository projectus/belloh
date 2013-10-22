class CreateHubPosts < ActiveRecord::Migration
  def change
    create_table :hub_posts do |t|
      t.string :content
      t.string :sender_desc
      t.string :receiver_desc
      t.string :mood, default: "neutral"
      t.integer :sender_id
      t.belongs_to :virtual_hub, index: true

      t.timestamps
    end
    add_index :hub_posts, :sender_id
  end
end
