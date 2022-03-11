module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, dependent: :destroy, as: :votable
  end

  def vote(user)
    Vote.create!(votable: self, score: 1, user: user)
  end

  def unvote(user)
    Vote.create!(votable: self, score: -1, user: user)
  end

  def count
    votes.sum(:score)
  end
end
