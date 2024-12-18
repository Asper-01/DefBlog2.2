class Article < ApplicationRecord
  # Associations
  belongs_to :author, class_name: 'User', foreign_key: "author_id"
  has_one_attached :image
  has_and_belongs_to_many :tags, join_table: :articletags
  has_many :comments, dependent: :destroy
  
  # Attribut virtuel pour la suppression d'image
  attr_accessor :remove_image

  # Validations
  validates :title, presence: true, length: { maximum: 80 }
  validates :content, presence: true

  # Callbacks
  before_save :purge_image_if_requested

  # Méthode pour trouver les articles reliés
  def related_articles(limit = 3)
    # Récupérer les IDs des tags associés à l'article actuel
    tag_ids = self.tags.pluck(:id)

    # Trouver les articles ayant des tags communs, exclure l'article actuel
    Article.joins(:tags)
          .where(tags: { id: tag_ids })
          .where.not(id: self.id) # Exclure l'article actuel
          .select("articles.*, COUNT(tags.id) AS shared_tags_count") # Compter les tags communs
          .group("articles.id")
          .order("shared_tags_count DESC, created_at DESC") # Trier par nombre de tags communs, puis par date
          .limit(limit) # Limiter à 3 articles
  end

  private

  # Supprime l'image si l'utilisateur demande sa suppression
  def purge_image_if_requested
    image.purge if ActiveModel::Type::Boolean.new.cast(remove_image)
  end
end
