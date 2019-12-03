require 'rails_helper'

#think of assigns[:book] as @book in the controller
describe BooksController do

  describe "not logged_in user" do
    describe "Get index" do
      let(:book){instance_double(Book)}
      before do
        allow(Book).to receive(:all){[book]}
      end

      it "renders :index template" do
        get :index
        expect(response).to render_template(:index)
      end
      it "assigns all the books to template" do
        get :index
        expect(assigns(:books)).to match_array([book])
      end
    end
  end

end


  describe "logged_in user" do
    let(:user){instance_double(User)}
    before do
      #allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe "Post create" do
      context "valid data" do
          let(:valid_data) {FactoryBot.attributes_for(:book)}
          it "create successfully, redircet to show" do
            post :create, params: {book: valid_data}
            expect(response).to redirect_to :action => :show,
                                          :id => assigns(:book).id
          end
          it "create successfully, new book in database" do
            expect{
              post :create, params: {book: valid_data}
          }.to change(Book, :count).by(1)
          end
      end

      context "invalid data" do
          let(:invalid_data){FactoryBot.attributes_for(:book, title:'')}
          it "renders :new template" do
            post :create, params: {book: invalid_data}
            expect(response).to render_template(:new)
          end
          it "doesn't create new data in database" do
            expect{
              post :create, params: {book: invalid_data}
              expect(response).to render_template(:new)
            }.not_to change(Book, :count)
          end
      end
    end

  end
