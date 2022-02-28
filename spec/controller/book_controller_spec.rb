require "rails_helper"

RSpec.describe BooksController, type: :controller do
  let(:book){FactoryBot.create_list(:book, 3)}
  describe "GET #index" do
    before do
      get :index, params: {term: book[0].book_title}
      @books = Book.search_by_tilte(book[0].book_title).newest
    end

    it "assigns @books" do
      expect(assigns(:books)).to match_array @books
    end

    it "renders the index template" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    context "book exist" do
      let(:author){FactoryBot.create :author}
      let(:book_authorship){FactoryBot.create(:book_authorship, book_id: book[0].id, author_id: author.id)}

      before do
        get :show, params: {id: book[0].id}
      end

      it "assigns @authors" do
        @authors = book[0].authors
        expect(assigns(:authors)).to match_array @authors
      end
    end

    context "book not exist" do
      before do
        get :show, params: {id: -1}
      end

      it {expect(flash[:danger]).to eq I18n.t("error.not_found_book")}
      it {expect(response).to redirect_to send("home_path")}
    end
  end

end
