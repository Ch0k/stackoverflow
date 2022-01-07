module Voted
  extend ActiveSupport::Concern
  included do
    before_action :set_votable, only: [ :vote, :unvote, :delete_vote, :delete_unvote]
  end

  def vote
    #if voted?(user)
    #else
      Vote.create!(votable_type: model_klass, votable_id: @votable.id, user_id: current_user.id)
      respond_to do |format|
        format.json { render json: {
                                      id: @votable.id,
                                      votes: @votable.votes.count,
                                      rating: @votable.votes.count - @votable.unvotes.count
                                    } 
                                  }
      end
    #end
  end

  def delete_vote
    @votable.votes.where(user_id: current_user.id).destroy_all
    respond_to do |format|
      format.json { render json: {
                                    id: @votable.id,
                                    votes: @votable.votes.count,
                                    rating: @votable.votes.count - @votable.unvotes.count
                                  } 
        }
    end
  end

  def unvote
    Unvote.create!(unvotable_type: model_klass, unvotable_id: @votable.id, user_id: current_user.id)
    respond_to do |format|
      format.json { render json: { 
                                    id: @votable.id,
                                    votes: @votable.votes.count,
                                    unvotes: @votable.unvotes.count,
                                    rating: @votable.votes.count - @votable.unvotes.count

        }
      }
    end
  end

  def delete_unvote
    @votable.unvotes.where(user_id: current_user.id).destroy_all
    respond_to do |format|
      format.json { render json: {
                                    id: @votable.id,
                                    votes: @votable.votes.count,
                                    unvotes: @votable.unvotes.count,
                                    rating: @votable.votes.count - @votable.unvotes.count

        }
      }
    end
  end

  private 
  
  def model_klass
    controller_name.classify.constantize
  end

  def set_votable
    @votable = model_klass.find(params[:id])
  end
end
