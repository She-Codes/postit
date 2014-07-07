class AddBackUserIdToVotes < ActiveRecord::Migration
  def change
    change_table :votes do |t|
      t.integer :user_id
    end
  end
end
