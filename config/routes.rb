Rails.application.routes.draw do
  get 'schedule/show'

  get 'news/show'

  get 'playerstat/show'

  get 'ballbyball/show'

  get 'cricket/show'

  get 'home/show'
  
  # get 'update_matchdetail/index' to 
  get '/update_page', to: 'ballbyball#show', as: :update_matchdetail 
  
  root 'cricket#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
