Rails.application.routes.draw do
  root 'to_dos#index'
  resources :to_dos
  
  # デフォルトでjson形式のファイルを返す
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :to_dos
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
