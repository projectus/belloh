class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
	    t.float :latitude
	    t.float :longitude
      t.text :content
      t.string :sender_desc
      t.string :receiver_desc
      t.string :mood

      t.timestamps
    end
  end
end
