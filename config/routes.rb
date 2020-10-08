Rails.application.routes.draw do

  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'register' => 'users#new'
  post 'register' => 'users#create'
  get 'user' => 'users#show'
  get 'user/edit' => 'users#edit', :as => 'user_edit'
  patch put 'user/update' => 'users#update', :as => 'user_update'

  post 'cart/add' => 'cart_items#create', :as => 'cart_items_add'
  post 'cart/refresh' => 'cart_items#refresh', :as => 'cart_items_refresh'
  post 'cart/update' => 'cart_items#update', :as => 'cart_items_update'
  delete 'cart/delete' => 'cart_items#destroy', :as => 'cart_items_delete'
  post 'cart/delete' => 'cart_items#destroy', :as => 'cart_items_delete_post'

  get 'cart' => 'carts#show'
  delete 'cart/clear' => 'carts#destroy', :as => 'cart_clear'

  resources :products

  # root :to => 'mall#index', :as => 'mall'
  root 'mall#index', as: 'mall'

  mount RuCaptcha::Engine => "/rucaptcha"

  get 'say/hello'
  get 'say/goodbye'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
