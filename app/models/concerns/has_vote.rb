module HasVote
  extend ActiveSupport::Concern
  included do
    has_many :votes, dependent: :destroy, as: :votable
  end

  def voted?(user)
    self.votes.where(user_id: user.id).count >= 1
  end
end
