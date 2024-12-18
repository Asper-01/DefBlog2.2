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
      respond_to do |format|
        format.html { redirect_to @article, alert: "Une erreur est survenue lors de l'ajout du commentaire." }
        format.turbo_stream
      end
    end
  end

    def new
      @article = Article.find(params[:article_id])
      @comment = @article.comments.build(parent_id: params[:parent_id])
    end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    Rails.logger.debug "Params reçus : #{params.inspect}"
    params.require(:comment).permit(:content, :article_id, :parent_id, :user_id, :created_at, :updated_at, :user, :article, :id)
  end
end
