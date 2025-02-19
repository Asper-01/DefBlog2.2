class CreateTags < ActiveRecord::Migration[7.1]
  def change
    create_table :tags do |t|
      t.string :name
      t.references :category, null: false, default: 1, foreign_key: true
      t.string :slug

      t.timestamps
    end
    add_index :tags, :slug, unique: true
  end
end
