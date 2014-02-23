Interngration::Application.routes.draw do
  resources :recruiters
  resources :students
  resources :sessions, only: [:new, :create, :destroy]

  root 'static_pages#student_landing_page'
  match '/contact', to: 'static_pages#contact',    via: 'get'
  match '/about', to: 'static_pages#about',    via: 'get'
  match '/recruiter', to: 'static_pages#recruiter_landing_page', via: 'get'
  match '/student_signup', to: 'students#new', via: 'get'
  match '/student_signin', to: 'sessions#new', via: 'get'
  match '/student_signout', to: 'sessions#destroy', via: 'delete'


end
