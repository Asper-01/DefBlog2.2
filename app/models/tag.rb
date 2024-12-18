class Tag < ApplicationRecord
  has_and_belongs_to_many :articles, join_table: :articletags
  belongs_to :category, foreign_key: :category_id
  validates :name, presence: true
  validates :category_id, presence: true


end
