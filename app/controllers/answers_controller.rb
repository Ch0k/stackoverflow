class AnswersController < ApplicationController
  include Voted

  before_action :authenticate_user!
  before_action :set_question, only: [:create]
  before_action :set_answer, only: [:destroy, :update]
  after_action :publish_answer, only: [:create]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      flash[:notice] = 'Answer successfuly created'
    end
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
    if current_user.author_of?(@answer)
      @answer.update(answer_params)
      @question = @answer.question
    else
      redirect_to root_path, notice: "You are not a author"
    end
  end

  def delete_file_attachment
    @file = ActiveStorage::Attachment.find(params[:id])
    @file.purge
    redirect_back fallback_location: root_path, notice: "Delete success"
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer     
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: [:id, :name, :url, :_destroy])
  end

  def publish_answer
    return if @answer.errors.any?
    ActionCable.server.broadcast(
      "question_#{@answer.question_id}_answers", {
        answer: @answer,
        count: @answer.count
      }
    )
  end
end
