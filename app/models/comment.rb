class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: 'parent_id'

  validates :content, presence: true

  private

  def parent_must_not_have_parent
    if parent&.parent_id.present?
      errors.add(:parent, "Vous ne pouvez pas répondre à une réponse.")
    end
  end
end
