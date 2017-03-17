Rails.application.routes.draw do
  get 'schedule/show'

  get 'news/show'

  get 'playerstat/show'

  get 'ballbyball/show'

  get 'cricket/show'

  get 'home/show'
  
  root 'cricket#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
