class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article
  before_action :admin_only, only: :destroy
  before_action :set_comment, only: [:destroy]

  def destroy
    Rails.logger.debug "Comment ID: #{params[:id]}"
    Rails.logger.debug "Found Comment: #{@comment.inspect}"

    if @comment.destroy
      flash[:notice] = "Le commentaire a été supprimé avec succès."
    else
      flash[:alert] = "Une erreur est survenue lors de la suppression du commentaire."
    end

    redirect_to article_path(@article)
  end

  def create
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to article_path(@article), notice: 'Commentaire ajouté avec succès.'
    else
      respond_to do |format|
        format.html { redirect_to @article, alert: "Une erreur est survenue lors de l'ajout du commentaire." }
        format.turbo_stream
      end
    end
  end

  def new
    @comment = @article.comments.build(parent_id: params[:parent_id])
  end

  private

  def set_comment
    @comment = Comment.find_by(id: params[:id])
    # Vérifier si le commentaire existe
    unless @comment
      flash[:alert] = "Commentaire introuvable."
      redirect_to article_path(@article)
    end
  end

  def set_article
    @article = Article.find_by!(slug: params[:article_slug])
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end

  def admin_only
    redirect_to root_path, alert: "Accès refusé." unless current_user.admin?
  end

end
