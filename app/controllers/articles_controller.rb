class ArticlesController < ApplicationController
  # Permet l'accès à index sans être connecté
  before_action :authenticate_user!, except: [:index, :show ]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_article, only: %i[show edit update destroy]

  def search
    query = params[:q]
    # Recherche dans le titre, contenu, et tags associés
    @results = Article.joins(:tags)  # Jointure avec la table tags
                      .where("articles.title ILIKE :query OR articles.content ILIKE :query OR tags.name ILIKE :query", query: "%#{query}%")
                      .distinct  # Assure qu'un article n'apparaisse qu'une seule fois dans les résultats

    render :search_results
  end

  def index
    @articles = Article.includes(:comments, :tags, image_attachment: :blob).order(created_at: :desc)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.author_id = current_user.id

    if @article.save
      redirect_to @article, notice: 'Article créé avec succès.'
    else
      render :new
    end

  end

  def show
    @article = Article.friendly.find(params[:slug])
    # Gérer une redirection si l'article a un previous_slug
    if @article.previous_slug.present?
      redirect_to article_path(@article), status: :moved_permanently and return
    end
    @comment = Comment.new # Création d'un nouvel objet Comment pour le formulaire
    @tags = @article.tags.includes(:category).order('categories.name DESC') # ou 'ASC' selon ton ordre préféré
    @comments = @article.comments.where(parent_id: nil) # Récupérer uniquement les commentaires principaux
    @related_articles = @article.related_articles
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article mis à jour avec succès.'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: 'Article supprimé avec succès.'
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :image)
  end

  def set_article
    @article = Article.friendly.find(params[:slug])
  end

  def require_admin
    redirect_to root_path, alert: "Accès réservé aux administrateurs." unless current_user.admin?
  end
end
