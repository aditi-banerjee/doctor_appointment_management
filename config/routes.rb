Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Api routes
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1 do
      namespace :doctor_appointment do
        post   'login',                                  to: 'users#login'
        resources :doctor_availablities, except: [:new, :edit]
        resources :appointments,         except: [:new, :edit, :update, :delete]
      end
    end
  end
end
