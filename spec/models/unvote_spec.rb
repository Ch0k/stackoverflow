require 'rails_helper'

RSpec.describe Unvote, type: :model do
  it { should belong_to :unvotable }
end
