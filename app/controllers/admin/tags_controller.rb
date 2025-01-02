module Admin
  class TagsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin
    before_action :set_tag, only: [:show, :edit, :update, :destroy]

    def index
      # Autoriser les paramètres sort et direction dans les paramètres de la requête
      permitted_params = params.permit(:search, :sort, :direction)

      # Gestion des paramètres de tri
      sort_column = %w[id name category_id].include?(permitted_params[:sort]) ? permitted_params[:sort] : "category_id" # Tri par défaut par catégorie
      sort_direction = %w[asc desc].include?(permitted_params[:direction]) ? permitted_params[:direction] : "asc" # Par défaut, tri ascendant

      # Recherche et tri des tags
      @tags = Tag.all.includes(:category) # Inclure les catégories pour éviter N+1 queries
      @tags = @tags.where("name ILIKE ?", "%#{permitted_params[:search]}%") if permitted_params[:search].present?
      @tags = @tags.order("#{sort_column} #{sort_direction}")

      # Pagination
      @tags = @tags.page(params[:page])
    end

    def show
      @tags = Tag.includes(:articles).page(params[:id])
    end

    def new
      @tag = Tag.new
    end

    def create
      Rails.logger.debug "Received params: #{params.inspect}"
      @tag = Tag.new(tag_params)
      if @tag.save
        redirect_to new_admin_tag_path, notice: "Tag créé avec succès."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @tag.update(tag_params)
        redirect_to admin_tags_path, notice: "Le tag a été mis à jour avec succès."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @tag.destroy
        redirect_to admin_tags_path, notice: "Tag supprimé avec succès."
      else
        redirect_to admin_tags_path, alert: "Erreur lors de la suppression du tag."
      end
    end

    private

    def set_tag
      @tag = Tag.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_tags_path, alert: "Tag non trouvé."
    end

    def tag_params
      params.require(:tag).permit(:name, :category_id)
    end
  end
end
