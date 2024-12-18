class TagsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    @articles = @tag.articles.order(created_at: :desc)
  end

  def new
    @tag = Tag.new
    @tags = Tag.order(:id) # Tri par ID
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to admin_tags_path, notice: 'Tag crée avec succès.'
    else
      render :new
    end
  end

  def edit
  end

  # Action de mise à jour
  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to admin_tag_path, notice: 'Le tag a été mis à jour avec succès.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Action suppresion
  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_path, notice: "Tag supprimé avec succès." }
      format.turbo_stream
    end
  end


  private

  def set_tag
    @tag = Tag.find(params[:id])  # Vérifie que params[:id] correspond bien à un ID valide
  rescue ActiveRecord::RecordNotFound
    redirect_to tags_path, alert: "Tag non trouvé"
  end

  def tag_params
    params.require(:tag).permit(:name, :category_id)
  end
end

private
