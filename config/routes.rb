Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "/home", to: "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/contact", to: "static_pages#contact"
    resources :books, only: %i(index show)
    resources :loaned_books
    resources :carts, except: %i(new show edit)

    namespace :admin do
      resources :books
      resources :loaned_books
    end
  end
end
