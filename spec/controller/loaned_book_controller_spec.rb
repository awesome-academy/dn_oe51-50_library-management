require "rails_helper"
include CartsHelper

RSpec.shared_examples "example flash & redirect" do |flag, mess, path|
  it {expect(flash[flag]).to eq I18n.t(mess)}
  it {expect(response).to redirect_to send("#{path}_path")}
end

RSpec.shared_examples "redirect home" do
  it {expect(response).to redirect_to home_path}
end

RSpec.describe LoanedBooksController, type: :controller do
  context "user is login" do
    let!(:user){FactoryBot.create :user}
    before(:each) do
      session[:user_id] = user.id
    end

    describe "GET #index" do
      before(:each) do
        FactoryBot.create_list(:loaned_book, 3, user_id: user.id)
        @loaned_books= user.loaned_books.newest
        get :index
      end

      it "assigns @loaned_books" do
        expect(assigns(:loaned_books)).to eq @loaned_books
      end
    end
    describe "POST #create" do
      let(:book){FactoryBot.create :book}

      context "success" do
        before do
          session[:cart] = {book.id.to_s => 1}
          post :create, params: {}
        end

        it "creates loan" do
          expect(user.loaned_books.count).to be > 0
        end

        it "assigns @cart" do
          @carts = get_all_item_in_cart
          expect(assigns(:carts)).to eq @carts
        end

        it {expect{assigns(:loaned_book).save!}.not_to raise_error}

        include_examples "example flash & redirect", :info, "notice.create_loan_success", "loaned_books"
      end

      context "failure" do
        context "with quantity zero or neg" do
          before do
            session[:cart] = {book.id.to_s => -1}
            post :create, params: {}
          end

          include_examples "example flash & redirect", :danger, "error.quantity.not_valid", "carts"
          it {expect{assigns(:loaned_book).save!}.to raise_error}
        end

        context "with quantity over permit" do
          before do
            session[:cart] = {book.id.to_s => 4}
            post :create, params: {}
          end

          include_examples "example flash & redirect", :danger, "error.quantity.over", "carts"
          it {expect{assigns(:loaned_book).save!}.to raise_error}
        end
      end
    end
  end

  context "user is not login" do
    describe "GET #index" do
      before do
        get :index
      end
      it {expect(response).to redirect_to login_url}
    end

    describe "POST #create" do
      before do
        session[:cart] = {"1" => 1}
        post :create, params: {}
      end
      it {expect(response).to redirect_to login_url}
    end
  end
end
