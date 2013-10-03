class AddSenderToPost < ActiveRecord::Migration
  def change
    add_column :posts, :sender_id, :integer
    add_index :posts, :sender_id
  end
end
