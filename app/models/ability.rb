class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :read, :update, :to => :user_setting

    if user.admin?
      can :manage, :all
    elsif user.member?
      can :user_setting, User
      can :read, [Book, LoanedBook, LoanedDetail, Category, Author]
      can :create, LoanedBook
      can :destroy, LoanedBook do |loaned|
        loaned.pending?
      end
      can :destroy, LoanedDetail do |loaned|
        loaned.pending?
      end
    else
      can :user_setting, User
      can :read, [Book, Author, Category]
    end
  end
end
