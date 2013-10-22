class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
	    t.float :latitude
	    t.float :longitude
	    t.string :city
	    t.string :country
      t.text :content
      t.string :sender_desc
      t.string :receiver_desc
      t.string :mood, default: 'neutral'
      t.integer :sender_id

      t.timestamps
    end
    add_index :posts, [:latitude, :longitude]
    add_index :posts, :sender_id
  end
end
