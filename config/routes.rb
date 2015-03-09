LearningMongodb::Application.routes.draw do

  namespace :api, defaults: {format: 'json'} do
    scope :v1 do
      post 'users' => 'users#create'
      post 'sessions' => 'sessions#create'


      resources :products, except: [:new, :edit, :destroy] do
        get 'close', on: :member
        post 'reviews' => 'reviews#create', on: :member
      end

    end
  end

end
