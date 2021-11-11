require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) {create(:user)}
  let(:question) { create(:question, user: user) } 
  describe 'GET #index' do
    let(:answers) { create_list(:answer,3, question:  question, user: user )}
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

  describe 'GET #edit' do
    let(:answer) { create(:answer, question: question, user: user)  }
    
    before { get :edit, params: { id: answer, question_id: question } }

    it 'assing the new answer to @answer' do 
      expect(assigns(:answer)).to eq answer
    end 

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    before { login(user) }
    context 'with valide attributes' do
      it 'create object in database' do 
        expect { post :create, params: {answer: attributes_for(:answer), question_id: question, user_id: user} }.to change(Answer,:count).by(1)
      end
      it 'redirect in show view' do 
        post :create, params: { answer: attributes_for(:answer), question_id: question } 
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalide attributes' do
      it 'does not save answer' do
        expect { post :create, params: {answer: attributes_for(:answer, :invalid), question_id: question, user_id: user} }.to_not change(Answer,:count)
      end
    
      it 're render new view' do
        post :create, params: {answer: attributes_for(:answer,:invalid), question_id: question, user_id: user} 
        expect(response).to redirect_to assigns(:question)
      end
    end
  end

  describe 'PATCH #update' do
    let(:answer) { create(:answer, question:  question )}

    context 'with valide attributes' do
    it 'assing the requested answer to @answer' do 
      patch :update, params: { id: answer, answer: attributes_for(:answer), question_id: question}
      expect(assigns(:answer)).to eq answer
    end 
    it 'change answer attribute' do 
      patch :update, params: { id: answer, answer: {body: 'new body new body new body new body new body'}, question_id: question}
      answer.reload
      expect(answer.body).to eq 'new body new body new body new body new body'
    end
    it 'redirect to update answer' do 
      patch :update, params: { id: answer, answer: attributes_for(:answer), question_id: question}
      expect(response).to redirect_to question
    end
    end

    context 'with invalide attributes' do
      before { patch :update, params: { id: answer, answer: attributes_for(:answer,:invalid), question_id: question} }
        it 'does not chenge answer' do
          answer.reload
          expect(answer.body).to eq 'MyText MyText MyText MyText'
        end
      
        it 're render edit view' do
          expect(response).to render_template :edit
        end
    end
  end

  describe 'DELETE #destroy' do
    let!(:question) { create(:question) } 
    let!(:answer) { create(:answer, question: question) } 
    it 'destroy answers in database' do
      expect{ delete :destroy, params: { id: answer, question_id: question } }.to change(Answer, :count).by(-1)
    end

    it 'redirect to index' do
      delete :destroy, params: { id: answer, question_id: question } 
      expect(response).to redirect_to answer.question
    end
  end
end
