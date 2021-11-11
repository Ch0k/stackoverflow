class AnswersController < ApplicationController
  before_action :set_question, only: [:index, :new, :edit, :create, :update]
  before_action :set_answer, only: [:update, :edit]

  def index
    @answers = @question.answers
  end

  def new
    @answer = @question.answers.new
  end

  def edit
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      redirect_to @question, notice: 'Answer successfuly created'
    else
      redirect_to @question
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find(params[:id])
    @answer.destroy
    redirect_to @answer.question, notice: "Answer deleted"
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_answer     
    @answer = Answer.find(params[:id])
  end
end
