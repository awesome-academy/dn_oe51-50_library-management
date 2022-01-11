Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "/home", to: "static_pages#home"
    get "/help", to: "static_pages#help"
    get "/contact", to: "static_pages#contact"
    resources :book, only: :show

    namespace :admin do
      resources :book
    end
  end
end
