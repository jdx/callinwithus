Callinwithus::Application.routes.draw do
  resources :conference_calls, :only => [ :new, :create, :show ]
  root :to => 'conference_calls#new'
end
