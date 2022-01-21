Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "/home", to: "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/contact", to: "static_pages#contact"
    
    resources :books, only: %i(index show)
    resources :carts, except: %i(new show edit)
    resources :loaned_books, only: %i(index show)

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users, only: %i(index new show create edit update)

    namespace :admin do
      resources :books
      resources :loaned_books
    end
  end
end
