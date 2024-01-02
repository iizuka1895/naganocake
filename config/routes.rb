Rails.application.routes.draw do
  
## admin
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
namespace :admin do
  resources :customers,only: [:index, :show, :edit, :update]
  resources :items,only: [:index, :new, :create, :edit, :update, :destroy]
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
  resources :customers,only: [:edit, :update, :show]
  resources :cart_items,only: [:index, :update, :create, :destroy]
  resources :orders,only: [:new, :index, :show, :create]
  get 'edit/customers' => 'customers#edit', as: "edit"
  patch 'update/customers' => 'customers#update', as: "update"
end

root 'public/homes#top'
get 'about' => 'public/homes#about', as: "about"

end
