class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :star
      t.integer :post_id
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :votes, :post_id
  end
end
