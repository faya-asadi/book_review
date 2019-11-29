require 'rails_helper'

#think of assigns[:book] as @book in the controller
describe BooksController  do

  shared_examples "public access to book" do
    let(:book){FactoryBot.create(:book)}
    describe "Get show" do
      it "renders show template" do
        get :show, params: { id: book.id }
        expect(response).to render_template(:show)
      end
      it "assign requested book to @book" do
        get :show, params: {id: book}
        expect(assigns(:book)).to eq(book)
      end
    end
    describe "Get index" do
      it "renders :index template" do
        get :index
        expect(response).to render_template(:index)
      end
      it "assigns all the books to template" do
        books = FactoryBot.create_list(:book, 5)
        get :index
        expect(assigns(:books)).to match_array(books)
      end
    end
  end

  describe "not logged_in user" do
    it_behaves_like "public access to book"
    let(:book){FactoryBot.create(:book)}
    let(:book_param_data) {FactoryBot.attributes_for(:book)}

    describe "Get new" do
      it "redirects to root_path" do
        get :new
        expect(response).to redirect_to root_path
      end
    end
    describe "Post create" do
      it "redirects to root_path" do
        post :create, params: {book: book_param_data}
        expect(response).to redirect_to root_path
      end
    end
    describe "Get edit" do
      it "redirects to root_path" do
        get :edit, params: {id: book.id}
        expect(response).to redirect_to root_path
      end
    end
    describe "Put update" do
      it "redirects to root_path" do
        put :update,  params: {id: book.id , book: book_param_data}
        expect(response).to redirect_to root_path
      end
    end
    describe "Delete destroy" do
      it "redirects to root_path" do
        delete :destroy, params: { id: book.id }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "logged_in user" do
    #no admin
    let(:user) {FactoryBot.create(:user)}
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    it_behaves_like "public access to book"

    describe "Get new" do
      it "renders :new template" do
        get :new
        expect(response).to render_template(:new)
      end
      it "assing new Book to @book" do
        get :new
        expect(assigns(:book)).to be_a_new(Book)
      end
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

    describe "Get edit" do
      let(:book) { FactoryBot.create(:book)}
      context "the user is the same as who created the book" do
        before do
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(book.user)
        end

        it " renders edit template" do
          get :edit, params: {id: book.id}
          expect(response).to render_template(:edit)
        end
        it "assigns the book with id equal to book_id" do
            get :edit, params: {id: book.id}
            expect(assigns(:book)).to eq(book)
          end
        end
        context "the user is different from who created the book" do
          it " renders edit template" do
            get :edit, params: {id: book.id}
            expect(response).to redirect_to root_path
          end
        end
      end



    describe "Delete destroy" do
        let(:book) { FactoryBot.create(:book)}
          context "user is admin" do
            let(:admin_user) {FactoryBot.create(:user, admin: true)}
            before do
              allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)
            end
            it "goes back to book index" do
              delete :destroy, params: { id: book.id }
              expect(response).to redirect_to(books_path)
            end
            it "number of books in DB is one less" do
              delete :destroy, params: { id: book.id }
              expect(Book.exists?(book.id)).to be_falsy
            end
          end

          context "user is not admin" do
            it "goes back to root path" do
              delete :destroy, params: { id: book.id }
              expect(response).to redirect_to(root_path)
            end
            it "number of books in DB won't change" do
              delete :destroy, params: { id: book.id }
              expect(Book.exists?(book.id)).to be_truthy
            end
          end
    end

  end

end
