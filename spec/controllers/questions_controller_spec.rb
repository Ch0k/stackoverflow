require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let!(:user) { create(:user) }
  let(:question) { create(:question, user: user) } 

  describe 'GET #index' do
    let(:questions) { create_list(:question,3, user: user) } 
    before { get :index }

    it 'populates an array of all question' do 

      expect(assigns(:questions)).to match_array(questions)
    end 
    
    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'assing the requested question to @question' do 
      expect(assigns(:question)).to eq question
    end 
    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { login(user) }
    before { get :new }
    
    it 'assing the new Question to @question' do 
      expect(assigns(:question)).to be_a_new(Question)
    end 

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { login(user) }
    before { get :edit, params: { id: question } }

    it 'assing the requested question to @question' do 
      expect(assigns(:question)).to eq question
    end
     
    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    before { login(user) }

    context 'with valide attributes' do
      it 'create object in database' do 
        expect { post :create, params: {question: attributes_for(:question)} }.to change(Question,:count).by(1)
      end
      it 'redirect in show view' do 
        post :create, params: {question: attributes_for(:question)} 
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalide attributes' do
      it 'does not save question' do
        expect { post :create, params: {question: attributes_for(:question, :invalid)} }.to_not change(Question,:count)
      end

      it 're render new view' do
        post :create, params: {question: attributes_for(:question,:invalid)} 
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
  
    describe 'Author of question' do
      before { login(user) }
      context 'with valide attributes' do
        let(:anwer) { create(:answer, user: user, question: question) }

        it 'assing the requested question to @question' do 
          patch :update, params: { id: question, question: attributes_for(:question)}
          expect(assigns(:question)).to eq question
        end 

        it 'change question attribute' do 
          patch :update, params: { id: question, question: {title: 'new title', body: 'new body'}}
          question.reload
          expect(question.title).to eq 'new title'
          expect(question.body).to eq 'new body'
        end

        it 'redirect to update question' do 
          patch :update, params: { id: question, question: attributes_for(:question)}
          expect(response).to redirect_to question
        end

        it 'select best answer' do
          patch :update, params: { id: question, question: {  best_answer_id: question.answers.first } }
          question.reload
          expect(question.best_answer).to eq question.answers.first
        end
      end

      context 'with invalide attributes' do

        before { patch :update, params: { id: question, question: attributes_for(:question, :invalid)} }
        it 'does not checnge question' do
          question.reload
          expect(question.title).to eq 'MyString'
          expect(question.body).to eq 'MyText'
        end

        it 're render edit view' do
          expect(response).to render_template :edit
        end
      end
    end

    describe "User not a author of question" do
      let!(:another_user) { create(:user) } 
      before { login(another_user) }
      context 'with valide attributes' do

        it 'assing the requested question to @question' do 
          patch :update, params: { id: question, question: attributes_for(:question)}
          expect(assigns(:question)).to eq question
        end
        
        it 'change question attribute' do 
          patch :update, params: { id: question, question: {title: 'new title', body: 'new body'}}
          question.reload
          expect(question.title).to eq question.title
          expect(question.body).to eq question.body
        end

        it 'redirect to update question' do 
          patch :update, params: { id: question, question: attributes_for(:question)}
          expect(response).to redirect_to questions_path
        end 
      end
    end
    context 'Not authenticate user update quesiton' do
      it 'assing the requested question to @question' do 
        patch :update, params: { id: question, question: attributes_for(:question)}
        expect(assigns(:question)).to_not eq question
      end
      
      it 'change question attribute' do 
        patch :update, params: { id: question, question: {title: 'new title', body: 'new body'}}
        question.reload
        expect(question.title).to eq question.title
        expect(question.body).to eq question.body
      end

      it 'redirect to update question' do 
        patch :update, params: { id: question, question: attributes_for(:question)}
        expect(response).to redirect_to new_user_session_path
      end 
    end
  end

  describe 'DELETE #destroy' do
  
    context "user is author of question" do
      before { login(user) }
      let!(:question) { create(:question, user: user) } 
      it 'destroy question in database' do
        expect{ delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
      end

      it 'redirect to index' do
        delete :destroy, params: { id: question}
        expect(response).to redirect_to questions_path
      end
    end

    context "user is not author of question" do
      let(:another_user) { create(:user) }
      let!(:question) { create(:question, user: user) } 
      before { login(another_user) }

      it 'do not destroy question in database' do
        expect{ delete :destroy, params: { id: question } }.to change(Question, :count).by(0)
      end

      it 'redirect to index' do
        delete :destroy, params: { id: question}
        expect(response).to redirect_to questions_path
      end
    end
  end
end
