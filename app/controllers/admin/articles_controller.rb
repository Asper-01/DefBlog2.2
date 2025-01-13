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
      sort_direction = params[:direction] || "desc" # Par défaut tri croissant

      @articles = @articles.order("#{sort_column} #{sort_direction}").page(params[:page]).per(10)
    end

    def show
      @article = Article.friendly.find(params[:slug])
    end

    def new
      @article = Article.new
      @articles = Article.all
    end

    def create
      @article = Article.new(article_params)
      @article.author = current_user
      @article.tag_ids = params[:article][:tag_ids] if params[:article][:tag_ids].present?
      if @article.save
        redirect_to admin_articles_path, notice: 'Article créé avec succès.'
      else
        render :new
      end
    end

    def edit
      @article = Article.friendly.find(params[:slug])
      @categories = Category.all
      @tags = @article.tags.pluck(:id)
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
      @article = Article.friendly.find(params[:slug])
      @article.destroy
      redirect_to admin_articles_path, notice: 'Article supprimé avec succès.'
    end

    private

    def article_params
      params.require(:article).permit(:title, :content, :image, :remove_image, :category_id, tag_ids: [])
    end

    def set_article
      @article = Article.friendly.find(params[:slug])
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_articles_path, alert: "Article introuvable."
    end
  end
end
