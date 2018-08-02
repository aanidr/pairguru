class AddUniqueConstraintToComments < ActiveRecord::Migration[5.2]
  def change
		add_index :comments, [:user_id, :movie_id], unique: true
  end
end
