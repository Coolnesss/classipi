Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/train', to: 'classify#train', as: 'train'
  post '/classify', to: 'classify#classify', as: 'classify'
  post '/register', to: 'users#register', as: 'register'
end
