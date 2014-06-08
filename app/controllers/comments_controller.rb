class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:id])
    
  end
end