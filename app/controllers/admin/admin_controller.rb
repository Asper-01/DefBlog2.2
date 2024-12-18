# app/controllers/admin/admin_controller.rb
module Admin
  class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin
    before_action :set_article, only: [:edit_article, :update_article, :destroy_article]

    # Affiche la liste des articles
    def articles
      @articles = Article.order(created_at: :desc).page(params[:page]).per(10)
    end

    # Affiche le formulaire d'édition d'un article
    def edit_article
    end

    # Met à jour un article
    def update_article
      if @article.update(article_params)
        redirect_to admin_articles_path, notice: "Article mis à jour avec succès."
      else
        render :edit_article
      end
    end

    # Supprime un article
    def destroy_article
      @article.destroy
      redirect_to admin_articles_path, alert: "Article supprimé avec succès."
    end

    private

    # Vérifie si l'utilisateur est un administrateur
    def check_admin
      unless current_user.admin?
        redirect_to root_path, alert: "Vous n'avez pas l'autorisation d'accéder à cette page."
      end
    end

    # Définit l'article courant pour les actions spécifiques
    def set_article
      @article = Article.find(params[:id])
    end

    # Permet uniquement certains paramètres pour les articles
    def article_params
      params.require(:article).permit(:title, :content, :image, tag_ids: [])
    end
  end
end
