require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) } 
  
  describe 'POST #create' do
    before { login(user) }
    context 'with valide attributes' do
      
      it 'create object in database' do 
        expect { post :create, params: {answer: attributes_for(:answer), question_id: question} }.to change(question.answers,:count).by(1)
      end

      it 'redirect in show view' do 
        post :create, params: { answer: attributes_for(:answer), question_id: question } 
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalide attributes' do

      it 'does not save answer' do
        expect { post :create, params: {answer: attributes_for(:answer, :invalid), question_id: question} }.to_not change(question.answers,:count)
      end
    
      it 're render new view' do
        post :create, params: {answer: attributes_for(:answer,:invalid), question_id: question} 
        expect(response).to render_template("questions/show")
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:question) { create(:question, user: user) } 
    let!(:answer) { create(:answer, question: question, user: user) }

    context 'user is author of answer' do
      before { login(user) }
      it 'destroy answers in database' do
        expect{ delete :destroy, params: { id: answer} }.to change(question.answers, :count).by(-1)
      end

      it 'redirect to index' do
        delete :destroy, params: { id: answer } 
        expect(response).to redirect_to answer.question
      end
    end

    context 'user is not author of answer' do
      let!(:another_user) { create(:user) }
      before { login(another_user) }
      it 'destroy answers in database' do
        expect{ delete :destroy, params: { id: answer} }.to change(question.answers, :count).by(0)
      end

      it 'redirect to sign_in' do
        delete :destroy, params: { id: answer } 
        expect(response).to redirect_to root_path
      end
    end
  end
end
