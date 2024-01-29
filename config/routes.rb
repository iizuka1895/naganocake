Rails.application.routes.draw do

## admin
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
namespace :admin do
  resources :customers,only: [:index, :show, :edit, :update]
  resources :items,only: [:index, :new, :show, :create, :edit, :update]
  resources :orders,only: [:index, :show, :update]
  resource :order_details,only: [:update]
end

## public
devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
namespace :public do
  resources :items,only: [:index, :show]
  resource :customers,only: [:edit, :update, :show] do
    collection do
      get 'check'
      patch 'withdraw'
    end
  end
  resources :cart_items,only: [:index, :update, :create, :destroy] do
    collection do
      delete 'destroy_all'
    end
  end
  resources :orders,only: [:new, :index, :show, :create] do
    collection do
      post 'confirm'
      get 'thanx'
    end
  end
  get '/customers/edit' => 'customers#edit', as: "edit"
  patch '/customers/update' => 'customers#update', as: "update"
end

root 'public/homes#top'
get 'about' => 'public/homes#about', as: "about"

end
