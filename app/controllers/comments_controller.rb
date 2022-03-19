class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :load_resource, only: [:create]

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to root_path, notice: 'Comment successfuly created'
    end
  end

  private

  def load_resource
    @klass = [Question, Answer].find { |klass| params["#{klass.name.underscore}_id"] }
    @commentable = @klass.find(params["#{@klass.name.underscore}_id"])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

end
