require 'rails_helper'
shared_examples_for 'is_votable' do
  it {  should have_many(:votes).dependent(:destroy)  }
end
