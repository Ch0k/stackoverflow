require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) } 

  describe 'GET #index' do
    let(:answers) { create_list(:answer,3, question:  question )}

    before { get :index, params: { question_id: question } }
    it 'populates an array of all question in question' do 
      expect(assigns(:answers)).to match_array(answers)
    end 
    
    it 'renders index view ' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    before { get :new, params: { question_id: question } }

    it 'assing the new Answer to @answer' do 
      expect(assigns(:answer)).to be_a_new(Answer)
    end 

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end
end
