module Admin
  class ArticlesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_article, only: [:edit, :update, :destroy]

    def index
      # Initialisation de la requête des articles
      @articles = Article.includes(:tags)

      # Recherche par titre
      if params[:search].present?
        @articles = @articles.where("title ILIKE ?", "%#{params[:search]}%")
      end

      # Tri par colonne et direction
      sort_column = params[:sort] || "created_at" # Par défaut trié par date
      sort_direction = params[:direction] || "asc" # Par défaut tri croissant

      @articles = @articles.order("#{sort_column} #{sort_direction}").page(params[:page]).per(5)
    end

    def show
      @article = Article.includes(:tags).find(params[:id])
    end

    def new
      @article = Article.new
      @articles = Article.all
    end

    def create
      @article = Article.new(article_params)
      @article.author = current_user
      if @article.save
        redirect_to admin_articles_path, notice: 'Article créé avec succès.'
      else
        render :new
      end
    end

    def edit
      @article = Article.find(params[:id])
    end

    def update
      if params[:article][:remove_image] == "1" && @article.image.attached?
        @article.image.purge
      end
      if @article.update(article_params)
        redirect_to admin_articles_path, notice: 'Article mis à jour avec succès.'
      else
        render :edit
      end
    end

    def destroy
      @article = Article.find(params[:id])
      @article.destroy
      redirect_to admin_articles_path, notice: 'Article supprimé avec succès.'
    end

    private

    def article_params
      params.require(:article).permit(:title, :content, :image, :remove_image, tag_ids: [])
    end

    def set_article
      @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_articles_path, alert: "Article introuvable."
    end
  end
end
