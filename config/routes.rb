Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  root to: "public/homes#top"
  get "about" => "public/homes#about"

  scope module: :public do
    resources :items, only: %i[index show]

    resource :customers do
      collection do
        get :mypage, to: "customers#show"
        get "mypage/edit", to: "customers#edit"
        patch "mypage/update", to: "customers#update"
        get :confirm
        patch :leave
      end
    end

    resources :cart_items, only: %i[index update create destroy] do
      collection do
        delete :destroy_all
      end
    end

    resources :orders, only: %i[new index show create] do
      collection do
        post :confirm
        get :complete
      end
    end

    resources :addresses, except: %i[new show]
  end

  namespace :admin do
    root "homes#top"

    resources :items, except: :destroy

    resources :genres, only: %i[index create edit update]

    resources :customers, only: %i[index show edit update] do
      member do
        get :orders
      end
    end

    resources :orders, only: %i[show update]

    resources :order_details, only: :update
  end
end
