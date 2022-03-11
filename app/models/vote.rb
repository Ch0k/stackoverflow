class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :score, presence: true
  validates_numericality_of :score, only_integer: true

  def vote(question, user)
    Vote.create!(votable: question, score: 1, user: user )
  end

  def unvote(question, user)
    Vote.create!(votable: question, score: -1, user: user )
  end
end
