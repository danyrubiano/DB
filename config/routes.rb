Rails.application.routes.draw do
  
  get 'activities/index'

  devise_for :users
  resources :posts

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :valorations, only: [:create]
  end

  resources :amigos, only: [:create, :destroy, :delete, :index]
  
  root "posts#inicio"

  get "/dashboard_usuarios", to: "welcome#usuarios"

  get '/perfil/:id', to: 'perfil#show', as: 'perfil' 

  get '/perfil/:id/following', to: 'perfil#following'

  get '/perfil/:id/followers', to: 'perfil#followers'

  delete "/users/:id/bloqueados", to: "perfil#bloquear"

  put "/users/:id/activos", to: "perfil#activar"
  
  get "/auditoria", to: "welcome#auditoria"

  get "/ser_gold", to: "welcome#serGold"

  get "/ser_normal", to: "welcome#serNormal"

  get "/compraGold", to: "welcome#compraGold"

  resources :relationships, only: [:create, :destroy]

end
