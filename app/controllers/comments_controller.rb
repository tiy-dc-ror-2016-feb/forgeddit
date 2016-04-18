class CommentsController < ApplicationController
  before_action :set_link, only: [:new, :show, :edit, :destroy, :update]
  before_action :set_comment, only: [:show, :edit, :destroy, :update]
  before_action :authorize_user_by_comment, only: [:edit, :destroy, :update]
  def index
    @comments = Comment.where(link_id: params[:link_id])
  end

  def new
    @comment = Comment.new
  end

  def show
  end

  def edit
  end

  def destroy
    @comment.destroy
    redirect_to link_comments_path(link_id: @comment.link_id)
  end

  def update
    @comment.update(comment_params)
    redirect_to link_comments_path(link_id: @comment.link_id)
  end

  def create
    @comment = current_user.comments.create!(comment_params)
    @comment.save
    redirect_to link_comments_path(link_id: @comment.link_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :link_id, :user_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_link
    @link = Link.find(params[:link_id])
  end

  def authorize_user_by_comment
    redirect_to(root_path, notice: "Go Away" ) unless @comment.user == current_user
  end
end
