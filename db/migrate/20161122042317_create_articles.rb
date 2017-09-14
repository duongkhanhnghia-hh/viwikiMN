class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :name, :null => false
      t.belongs_to :category, :null => false

      t.timestamps
    end
  end
end
