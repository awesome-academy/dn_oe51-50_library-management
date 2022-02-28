Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "books#index"
    get "/home", to: "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/contact", to: "static_pages#contact"

    resources :books, only: %i(index show)
    resources :loaned_books
    resources :carts, except: %i(new show edit) do
      collection do
        patch "/update", to: "carts#update"
      end
    end

    devise_for :users, controllers: {sessions: "sessions"}

    devise_scope :user do
      get "login", to: "sessions#new"
      delete "logout", to: "sessions#destroy"
    end

    resources :users

    namespace :admin do
      resources :books
      resources :loaned_books do
        collection do
          patch "update_status", to: "loaned_books#update_status"
        end
      end
    end
  end
end
