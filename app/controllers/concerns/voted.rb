module Voted
  extend ActiveSupport::Concern

  included do
    before_action :find_votable, only: %i[vote unvote revote]
  end

  def vote
    @votable.vote(current_user)
    render_json
  end

  def unvote
    @votable.unvote(current_user)
    render_json
  end

  def revote
    @votable.revote(current_user)
    render_json
  end

  private

  def model_klass
    controller_name.classify.constantize
  end

  def find_votable
    @votable = model_klass.find(params[:id])
  end

  def render_json(*flash)
    render json: {
                   score: @votable.count,
                   klass: @votable.class.to_s,
                   id: @votable.id,
                   flash: flash
                 }
  end
end
