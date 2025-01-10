class AddPreviousSlugToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :previous_slug, :string
  end
end
