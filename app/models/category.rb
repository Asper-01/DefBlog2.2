class Category < ApplicationRecord
  has_many :tags, dependent: :destroy
end
