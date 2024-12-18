class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to article_path(@article), notice: 'Commentaire ajouté avec succès.'
    else
      @comments = @article.comments.order(created_at: :desc) # Nécessaire pour afficher les commentaires existants
      render 'articles/show' # Rester sur la page actuelle avec les erreurs
    end
  end



  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    Rails.logger.debug "Params reçus : #{params.inspect}"
    params.require(:comment).permit(:content, :article_id, :user_id, :created_at, :updated_at, :user, :article, :id)
  end
end
