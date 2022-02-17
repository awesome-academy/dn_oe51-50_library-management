require "rails_helper"
include CartsHelper

RSpec.shared_examples "assign flash" do |flag ,message|
  it {expect(assigns(:book)).to eq @book}
  it {expect(flash[flag]).to eq I18n.t(message)}

end

RSpec.shared_examples "flash redirect cart" do |flag ,message|
  it {expect(flash[flag]).to eq I18n.t(message)}
  it {expect(response).to redirect_to carts_path}
end

RSpec.describe CartsController, type: :controller do
  let!(:book) {FactoryBot.create :book}

  describe "GET #index" do
    before do
      session[:cart] = {}
      @carts = get_all_item_in_cart
    end

    context "user login" do
      let!(:user) {FactoryBot.create :user}

      before do
        session[:user_id] = user.id
        get :index
      end

      it "assigns @carts" do
        expect(assigns(:carts)).to eq @carts
      end

      it "renders the index template" do
        expect(response).to render_template :index
      end
    end

    context "user unlogin" do
      before do
        get :index
      end

      it "redirect login" do
        expect(response).to redirect_to login_url
      end
    end
  end

  describe "POST #create" do
    let!(:user) {FactoryBot.create :user}

    before do
      session[:user_id] = user.id
      session[:cart] = {}
    end

    context "when book exist" do
      before do
        @book = book
        post :create, params: {id: book.id, quantity: 1}
      end

      include_examples "assign flash", :success, "notice.add_cart_success"

      it "add to cart success" do
        expect(session[:cart][book.id].to_i).to eq 1
      end

      it "has a 302 status code" do
        expect(response).to have_http_status(:found)
      end

      it "redirect book" do
        expect(response).to redirect_to book_path(@book)
      end
    end

    context "when product does not exist" do
      before do
        post :create, params: {id: -1, quantity: 1}
      end

      it "show flash message" do
        expect(flash[:danger]).to eq I18n.t("error.not_found_book")
      end

      it "redirect home" do
        expect(response).to redirect_to home_path
      end
    end

    context "when quantity is over permit range" do
      before do
        @book = book
        post :create, params: {id: book.id, quantity: 4}
      end

      include_examples "assign flash", :danger, "error.quantity.over"
    end

    context "when quantity is invalid" do
      before do
        session[:user_id] = user.id
        session[:cart] = {}
        @book = book
        post :create, params: {id: book.id, quantity: 0}
      end

      include_examples "assign flash", :danger, "error.quantity.not_valid"

      it "redirect book" do
        expect(response).to redirect_to book_path(@book)
      end
    end
  end

  describe "PUT #update" do
    let!(:user) {FactoryBot.create :user}

    before do
      session[:user_id] = user.id
      session[:cart] = {book.id.to_s => 1}
    end

    context "when product exist" do
      before do
        put :update, params: {id: book.id, quantity: 2}
      end

      it "update success" do
        expect(session[:cart][book.id.to_s].to_i).to eq 2
      end

      it "has a 204 status code" do
        expect(response).to have_http_status(:no_content)
      end
    end
    context "when product does not exist" do
      before do
        put :update, params: {id: -1, quantity: 2}
      end

      it "update failure" do
        expect(session[:cart][book.id.to_s].to_i).to eq 1
      end

      include_examples "flash redirect cart", :danger, "error.not_found_in_cart"
    end

    context "when quantity is over permit range" do
      before do
        put :update, params: {id: book.id, quantity: 4}
      end

      it "assign quantity over three" do
        expect(assigns(:quantity)).to be > Settings.limit_loans.maximum
      end

      include_examples "flash redirect cart", :danger, "error.quantity.over"
    end
  end

  describe "DELETE #destroy" do
    let!(:user) {FactoryBot.create :user}

    before do
      session[:user_id] = user.id
      session[:cart] = {book.id.to_s => 1}
    end

    context "when product exist" do
      before do
        delete :destroy, params: {id: book.id}
      end

      it "delete success" do
        expect(session[:cart]).to be_empty
      end

      include_examples "flash redirect cart", :success, "notice.del_success"
    end

    context "when product does not exist" do
      before do
        delete :destroy, params: {id: -1, quantity: 2}
      end

      include_examples "flash redirect cart", :danger, "error.not_found_in_cart"
    end
  end
end
