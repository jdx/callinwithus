Callinwithus::Application.routes.draw do
  resources :conference_calls, :only => [ :new, :create, :show ]
  match 'twilio/call' => 'twilio#call'
  #post 'twilio/call' => 'twilio#call'
  root :to => 'conference_calls#new'
end
