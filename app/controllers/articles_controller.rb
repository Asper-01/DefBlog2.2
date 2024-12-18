class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show ]  # Permet l'accès à index sans être connecté
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_article, only: %i[show edit update destroy]

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
    @article = Article.find(params[:id])
    @comment = Comment.new # Création d'un nouvel objet Comment pour le formulaire
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
    @article = Article.find(params[:id])
  end

  def require_admin
    redirect_to root_path, alert: "Accès réservé aux administrateurs." unless current_user.admin?
  end
end
