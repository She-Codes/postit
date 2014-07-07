class RemoveUserIdFromVotes < ActiveRecord::Migration
  def change
    change_table :votes do |t|
      t.remove :user_id
    end
  end
end
