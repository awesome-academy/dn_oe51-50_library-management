require "rails_helper"

RSpec.describe User, type: :model do
  subject {FactoryBot.create :user}

  describe "validations" do
    it {is_expected.to be_kind_of(ApplicationRecord)}
    it {is_expected.to be_a_kind_of(ApplicationRecord)}
    it {is_expected.to be_a(ApplicationRecord)}

    it {is_expected.to be_valid}
    it {is_expected.to validate_presence_of(:role)}
    it {is_expected.to validate_presence_of(:name)}
    it {is_expected.to validate_presence_of(:address)}
    it {is_expected.to validate_presence_of(:email)}
    it {is_expected.to validate_presence_of(:phone_number)}
    it {is_expected.to validate_presence_of(:city)}
    it {is_expected.to validate_presence_of(:password_digest)}
    it {is_expected.to have_secure_password}
    it {is_expected.to define_enum_for(:role).with_values(%w(admin member guest))}

    it {expect(User.roles[:admin]).to eql 0}
    it {expect(User.roles[:member]).to eql 1}
    it {expect(User.roles[:guest]).to eql 2}
  end

  describe "associations" do
    let!(:quantity) {1}
    let!(:book) {FactoryBot.create :book}
    let!(:loaned_book) {
      LoanedBook.create(
        user_id: subject.id,
        date_loaned: Time.now,
        date_due: Time.now + Settings.df_date_due.days,
        date_returned: nil,
        overdue_fee: nil,
        status: LoanedBook.statuses[:pending],
        quantity: quantity
      )
    }
    let!(:loaned_details) {FactoryBot.create_list(:loaned_detail, 2, loaned_book_id: loaned_book.id, book_id: book.id, quantity: quantity)}

    it {is_expected.to have_many(:loaned_books)}
    it {is_expected.to have_many(:loaned_details)}

    it "user and loaned book" do
      expect{subject.loaned_books}.not_to raise_error
    end

    it "user and loaned details" do
      expect{subject.loaned_details}.not_to raise_error
    end

    it "user and loaned book and loaned details" do
      expect{subject.loaned_books[0].loaned_details}.not_to raise_error
    end

    %w[id user_id date_loaned date_due date_returned overdue_fee status quantity].each do |atr|
      it "get #{atr} in loaned books" do
        atr_loan = subject.loaned_books[0].send(atr)
        expect(atr_loan).to eql loaned_book.send(atr)
      end
    end
  end

  describe "method" do
    let!(:quantity) {1}
    let!(:book) {FactoryBot.create :book}
    let!(:loaned_book) {
      LoanedBook.create(
        user_id: subject.id,
        date_loaned: Time.now,
        date_due: Time.now + Settings.df_date_due.days,
        date_returned: nil,
        overdue_fee: nil,
        status: LoanedBook.statuses[:pending],
        quantity: quantity
      )
    }
    let!(:loaned_details) {FactoryBot.create_list(:loaned_detail, 2, loaned_book_id: loaned_book.id, book_id: book.id, quantity: quantity)}

    it "with .is valid member" do
      expect(User.is_valid_member? subject).to be true
    end

    it "with .is valid member not raise error" do
      expect{User.is_valid_member? subject}.not_to raise_error
    end

    it "with .is valid member with admin arg" do
      subject.admin!
      expect(User.is_valid_member? subject).to be false
    end

    it "with .get total loaned books" do
      expect(User.get_total_loaned_books subject).to eql 2
    end

    it "with #digest with min cost" do
      ActiveModel::SecurePassword.min_cost = true
      expect(subject.digest subject.password).to match /^\$2[ayb]\$.{56}$/
    end

    it "with #digest with cost" do
      ActiveModel::SecurePassword.min_cost = false
      expect(subject.digest subject.password).to match /^\$2[ayb]\$.{56}$/
    end

    it "with #digest compare pass" do
      expect(subject.digest subject.password).not_to eql subject.password
    end
  end
end
