class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :load_question, only: [:create]

  def create
    @comment = @question.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @question, notice: 'Comment successfuly created'
    end
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

end
