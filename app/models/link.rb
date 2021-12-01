class Link < ApplicationRecord
  GIST = 'https://gist.github.com'
  belongs_to :linkable, polymorphic: true
  
  validates :name, :url, presence: true
  validates :url, format: { with: /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/ix,
    message: "unvalid" }

  def gist?
    GIST.in? self.url
  end
end
