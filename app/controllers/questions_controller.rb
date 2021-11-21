class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else 
      render :new
    end
  end

  def update
    if current_user.author_of?(@question)
      if @question.update(question_params)
        redirect_to @question, notice: 'Question updated'
      else 
        render :edit
      end
    else
      redirect_to questions_path, notice: "You are not a author"
    end
  end

  def index
    @questions = Question.all
  end

  def show
    #@answers = @question.answers
    #@answer = @question.answers.build
    @best_answer = @question.best_answer
    @answer = Answer.new
    @other_answers = @question.answers.where.not(id: @question.best_answer_id)
  end

  def new
    @question = Question.new
  end

  def edit
    if current_user.author_of?(@question)
      render :edit
    else
      redirect_to @question
      flash[:notice] = "You are not a author"
    end
  end

  def destroy
    if current_user.author_of?(@question)
      @question.destroy
      redirect_to questions_path, notice: "Question deleted"
    else
      redirect_to questions_path, notice: "You are not a author"
    end
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, :best_answer_id)
  end

end
