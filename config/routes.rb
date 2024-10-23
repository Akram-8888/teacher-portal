Rails.application.routes.draw do
  # Root path for the application, points to the teacher's home/student listing
  devise_for :teachers

  # Set the root path to the teacher's home
  root to: 'teachers#home'

  # Custom routes for teacher portal
  resources :students

  # You can also define a custom route for login (if needed)
  devise_scope :teacher do
    get 'login', to: 'devise/sessions#new'
  end
end
