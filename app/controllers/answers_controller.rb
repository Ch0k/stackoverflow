class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:create]
  before_action :set_answer, only: [:destroy, :update]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
    #flash[:notice] = 'Answer created!'
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
      redirect_to @answer.question, notice: "Answer deleted"
    else
      redirect_to root_path, notice: "You are not a author"
    end
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer     
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
