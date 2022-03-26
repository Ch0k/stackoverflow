class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :load_resource, only: [:create]
  after_action :publish_comment, only: [:create]

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

  def publish_comment
    question_id = @klass == Question ? @commentable.id : @commentable.question.id
    return if @comment.errors.any?
    ActionCable.server.broadcast(
      "question_#{question_id}_comments", {
        comment: @comment,
        user: @comment.user
      }
    )
  end
end
