Rails.application.routes.draw do
  root 'static_pages#home'

  get    '/signup',  		     to: 'users#new'
  post   '/signup',  		     to: 'users#create'
  get     '/login', 	       to: 'sessions#new'
  post    '/login', 	       to: 'sessions#create'
  delete '/logout',  		     to: 'sessions#destroy'
  post   '/users_from_file', to: 'users#create_csv'


  # resources :project
  
  resources :users do
    resources :reimbursements
    resources :allowances
    resources :dope_adjustments
    resources :nope_adjustments
    resources :payslips do
      member do
        post :toggle_paid
        post :toggle_pay_all
        post :toggle_unpay_all
        get  :sss_bracket
        get  :philhealth_bracket
        get  :pagibig_bracket
        get  :withholding_bracket
      end
    end
  end

  resources :payrolls


  # , only: [:edit, :delete, :create, :update, :destroy, :new, :index]

  # resources :reimbursements

end