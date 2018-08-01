class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
			t.references :user
			t.references :movie

      t.timestamps
    end
  end
end
