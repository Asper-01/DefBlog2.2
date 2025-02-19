class CreateArticletags < ActiveRecord::Migration[7.1]
  def change
    create_table :articletags do |t|
      t.references :article, null: false, foreign_key: true
      t.references :tag, null: false


      t.timestamps
    end
  end
end
