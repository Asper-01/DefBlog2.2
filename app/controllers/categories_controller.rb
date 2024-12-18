class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all

    # Recherche par titre
    if params[:search].present?
      @categories = @categories.where("name ILIKE ?", "%#{params[:search]}%")
    end

    # Tri par colonne et direction
    sort_column = params[:sort] || "created_at" # Par défaut trié par date
    sort_direction = params[:direction] || "asc" # Par défaut tri croissant

    @categories = @categories.order("#{sort_column} #{sort_direction}").page(params[:page]).per(5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to new_admin_category_path, notice: "Catégorie créée avec succès."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "Catégorie mise à jour avec succès."
    else
      render :edit
    end
  end

  def destroy
    @category.tags.clear # Dissocier les tags avant suppression
    @category.destroy
    redirect_to admin_categories_path, notice: "Catégorie supprimée avec succès."
  end

  def tags
    category = Category.find(params[:id])
    render json: category.tags.select(:id, :name) # Renvoie l'id et le nom des tags
  end
  
  private

  def set_category
    # Recherche d'une catégorie existante uniquement pour l'édition, la mise à jour et la suppression
    @category = Category.find(params[:id]) if params[:id].present?
  end

  def category_params
    # Ici, on permet uniquement le paramètre `name` pour la création et la mise à jour de la catégorie
    params.require(:category).permit(:name)
  end
end
