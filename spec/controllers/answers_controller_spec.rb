require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) } 
  
  describe 'POST #create' do
    before { login(user) }
    context 'with valide attributes' do
      
      it 'create object in database' do 
        expect { post :create, params: {
          answer: attributes_for(:answer), 
          question_id: question}, 
          format: :js }.to change(question.answers,:count).by(1)
      end

      it 'redirect in show view' do 
        post :create, params: { 
          answer: attributes_for(:answer), 
          question_id: question,
          format: :js } 
        expect(response).to render_template :create
      end
    end

    context 'with invalide attributes' do

      it 'does not save answer' do
        expect { post :create, params: {
          answer: attributes_for(:answer, :invalid),
          question_id: question},
          format: :js }.to_not change(question.answers,:count)
      end
    
      it 're render new view' do
        post :create, params: {
          answer: attributes_for(:answer,:invalid), 
          question_id: question },
          format: :js
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    let!(:answer) { create(:answer, question: question, user: user) }
    describe 'User is author of answer' do
      before { login(user) }
      context 'with valid attributes' do
        it 'changes answer attributes' do
          patch :update, params: { 
            id: answer, 
            answer: { body: 'new body new body ' } }, 
            format: :js
          answer.reload
          expect(answer.body).to eq 'new body new body '
        end
  
        it 'renders update view' do
          patch :update, params: { 
            id: answer, 
            answer: { body: 'new body' } }, 
            format: :js
          expect(response).to render_template :update
        end
      end
  
      context 'with invalid attributes' do
        it 'does not change answer attributes' do
          expect do
            patch :update, params: { 
              id: answer, 
              answer: attributes_for(:answer, :invalid), 
              format: :js }
          end.to_not change(answer, :body)
        end
      
        it 'renders update view' do
          patch :update, params: { 
            id: answer, 
            answer: attributes_for(:answer, :invalid) }, 
            format: :js
          expect(response).to render_template :update
        end
      end
    end

    describe 'User is not a author of answer' do
      let(:another_user) { create(:user) }
      before { login(another_user) }
      context 'do not chenge answer attributes' do
        it 'valid attributes' do
          expect do
            patch :update, params: { 
              id: answer, 
              answer: attributes_for(:answer), 
              format: :js }
          end.to_not change(answer, :body)
        end

        it 'render question' do
          patch :update, params: { 
            id: answer, 
            answer: attributes_for(:answer) }, 
            format: :js
          expect(response).to redirect_to root_path
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:question) { create(:question, user: user) } 
    let!(:answer) { create(:answer, question: question, user: user) }

    context 'user is author of answer' do
      before { login(user) }
      it 'destroy answers in database' do
        expect{ delete :destroy, params: { 
          id: answer }, 
          format: :js }.to change(question.answers, :count).by(-1)
      end

      it 'redirect to index' do
        delete :destroy, params: { id: answer }, format: :js
        expect(response).to redirect_to answer.question
      end
    end

    context 'user is not author of answer' do
      let!(:another_user) { create(:user) }
      before { login(another_user) }
      it 'destroy answers in database' do
        expect{ delete :destroy, params: { 
          id: answer}, 
          format: :js}.to change(question.answers, :count).by(0)
      end

      it 'redirect to sign_in' do
        delete :destroy, params: { id: answer }, format: :js
        expect(response).to redirect_to root_path
      end
    end
  end
end
