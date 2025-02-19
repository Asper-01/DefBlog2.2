class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true
      t.text :content
      t.integer :parent_id

      t.timestamps
    end
    add_index :comments, :parent_id
  end
end
