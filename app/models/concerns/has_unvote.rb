module HasUnvote
  extend ActiveSupport::Concern
  included do
    has_many :unvotes, dependent: :destroy, as: :unvotable
  end

  def unvoted?(user)
    self.unvotes.where(user_id: user.id).count >= 1
  end
end
