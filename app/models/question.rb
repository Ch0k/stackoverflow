class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :user
  belongs_to :best_answer, class_name: 'Answer', optional: true
  has_many :links, dependent: :destroy,as: :linkable
  has_many :votes, dependent: :destroy, as: :votaable
  has_one :badge

  after_update :after_update_add_badge

  
  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank
  accepts_nested_attributes_for :badge
  
  validates :title, :body, presence: true

  def after_update_add_badge
    if self.badge.present?
      self.best_answer.user.badges << self.badge
    end
  end
end
