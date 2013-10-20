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

      t.timestamps
    end
    add_index :posts, [:latitude, :longitude]
  end
end
