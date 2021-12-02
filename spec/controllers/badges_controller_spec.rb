require 'rails_helper'

RSpec.describe BadgesController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #index' do
    before { login(user) }
    before { get :index }

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end
end
