Rails.application.routes.draw do

  namespace :admin do
    get 'orders/show'
  end
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
  namespace :admin do
    get 'genres/index'
    get 'genres/edit'
  end
  namespace :admin do
    get 'items/index'
    get 'items/new'
    get 'items/show'
    get 'items/edit'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'addresses/index'
    get 'addresses/edit'
  end
  namespace :public do
    get 'orders/new'
    get 'orders/confirm'
    get 'orders/complete'
    get 'orders/index'
    get 'orders/show'
  end
  namespace :public do
    get 'cart_items/index'
  end
  namespace :public do
    get 'customers/show'
    get 'customers/edit'
    get 'customers/confirm'
  end
  namespace :public do
    get 'items/index'
    get 'items/show'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  root to: "homes#tpp"
  get "about" => "homes#about"

  scope module: :public do
    resources :items, only: %i[index show]

    resources :customers, only: %i[show edit update] do
      member do
        get :confirm
        patch :leave
      end
    end

    resources :cart_items, only: %i[idnex update create destroy] do
      collection do
        delete :destroy_all
      end
    end

    resources :orders, only: %i[new index show create] do
      member do
        get :confirm
        get :complate
      end
    end

    resources :addresses, except: %i[new show]
  end

  namespace :admin do
    root "homes#top"

    resources :items, except: :destroy

    resources :genres, only: %i[index create edit update]

    resources :customers, only: %i[index show edit update]

    resources :orders, only: %i[show update]

    resources :orede_details, only: :update
  end
end
