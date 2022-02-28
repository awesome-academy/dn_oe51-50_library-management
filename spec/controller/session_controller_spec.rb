require "rails_helper"
include SessionsHelper

RSpec.describe SessionsController, type: :controller do
  describe "Test extend" do
    it {is_expected.to be_kind_of(ApplicationController)}
    it {is_expected.to be_a_kind_of(ApplicationController)}
    it {is_expected.to be_a(ApplicationController)}
  end

  describe "POST #create" do
    let!(:user){FactoryBot.create :user}

    context "success" do
      before do
        post :create, params: {session: {email: user.email, password: user.password}}
      end

      it {expect(logged_in?).to be true}
      it {expect(response).to redirect_to root_url}
    end

    context "failure" do
      before do
        post :create, params: {session: {email: user.email, password: "wrongpass"}}
      end

      it {expect(logged_in?).to be false}
      it {expect(flash[:danger]).to eq I18n.t("flash.invalid_email_password_combination")}
      it {expect(response).to render_template :new}
    end
  end

  describe "DELETE #destroy" do
    let(:user) {FactoryBot.create :user}
    before do
      session[:user_id] = user.id
      delete :destroy, params: {}
    end

    it {expect(response).to redirect_to root_url}
    it {expect(session[:user_id]).to eql nil}
  end
end
