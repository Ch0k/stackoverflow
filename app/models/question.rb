class Question < ApplicationRecord
  include Votable

  has_many :answers, dependent: :destroy
  belongs_to :user
  belongs_to :best_answer, class_name: 'Answer', optional: true
  has_many :links, dependent: :destroy,as: :linkable
  has_one :badge, dependent: :destroy
  has_many :comments, dependent: :destroy, as: :commentable

  after_update :after_update_add_badge

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank
  accepts_nested_attributes_for :badge, reject_if: :all_blank
  
  validates :title, :body, presence: true

  def after_update_add_badge
    if self.badge.present?
      self.best_answer.user.badges << self.badge
    end
  end
end
