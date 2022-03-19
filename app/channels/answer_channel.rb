class AnswerChannel < ApplicationCable::Channel
  def follow
    #question = GlobalID::Locator.locate(params[:id])
    stream_for 'answer'
  end
end
