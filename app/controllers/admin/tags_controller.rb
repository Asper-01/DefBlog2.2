module Admin
  class TagsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin
    before_action :set_tag, only: [:show, :edit, :update, :destroy]

    def index
      # Gestion des paramètres de tri
      sort_column = %w[id name].include?(params[:sort]) ? params[:sort] : "id" # Par défaut, tri par ID
      sort_direction = %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc" # Par défaut, tri ascendant

      # Recherche et tri des tags
      @tags = Tag.all
      @tags = @tags.where("name ILIKE ?", "%#{params[:search]}%") if params[:search].present?
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
