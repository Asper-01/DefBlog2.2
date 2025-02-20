class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  before_save :store_previous_slug, if: :slug_changed?
  def should_generate_new_friendly_id?
    true
  end

  # Associations
  belongs_to :author, class_name: 'User', foreign_key: "author_id"
  has_one_attached :image
  has_and_belongs_to_many :tags, join_table: :articletags
  has_many :comments, dependent: :destroy
  has_many :categories, through: :tags

  # Attribut virtuel pour la suppression d'image
  attr_accessor :remove_image
  has_one_attached :image

  # Validations
  validates :title, presence: true, length: { maximum: 500 }
  validates :content, presence: true
  validates :image, content_type: ['image/png', 'image/jpeg', 'image/webp']

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

  # Réseaux sociaux et partages des articles
  def excerpt
    ActionController::Base.helpers.strip_tags(content.truncate(150))
  end

    # Méthode pour redimensionner les images et les convertir en Webp
    def optimized_image
      image.variant(resize_to_limit: [900, 900], format: :webp, saver: { quality: 90 }).processed
    end


  private

  def store_previous_slug
    self.previous_slug = slug_was
  end
  # Supprimer les images si demandé
  def purge_image_if_requested
    image.purge if ActiveModel::Type::Boolean.new.cast(remove_image)
  end
end
