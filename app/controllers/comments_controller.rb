class CommentsController < ApplicationController
  before_action :set_post
  
  def create
    
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @vote = Vote.create(voteable: @comment)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end