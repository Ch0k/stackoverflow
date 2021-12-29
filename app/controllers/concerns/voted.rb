module Voted
  extend ActiveSupport::Concern
  included do
    before_action :set_votable, only: [ :vote, :unvote, :delete_vote, :delete_unvote]
  end

  def vote
    Vote.create!(votable_type: model_klass, votable_id: @votable.id, user_id: current_user.id)
    redirect_back fallback_location: root_path, notice: "Vote success"
  end

  def delete_vote
    @votable.votes.where(user_id: current_user.id).destroy_all
    redirect_back fallback_location: root_path, notice: "Vote delete"
  end

  def unvote
    Unvote.create!(unvotable_type: model_klass, unvotable_id: @votable.id, user_id: current_user.id)
    redirect_back fallback_location: root_path, notice: "Unvote success"
  end

  def delete_unvote
    @votable.unvotes.where(user_id: current_user.id).destroy_all
    redirect_back fallback_location: root_path, notice: "Unvote delete"
  end

  private 
  
  def model_klass
    controller_name.classify.constantize
  end

  def set_votable
    @votable = model_klass.find(params[:id])
  end
end
