Rails.application.routes.draw do

  scope module: 'store' do
    resources :categories, only: [:show]
  end

  root to: 'store/pages#home'
end
