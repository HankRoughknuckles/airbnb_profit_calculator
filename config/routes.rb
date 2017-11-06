Rails.application.routes.draw do
  root 'calculation#new'
  post '/calculaton', to: 'calculation#create', as: 'calculation'
end
