ShapeDrawer::Application.routes.draw do
  root :to => 'fonts#index'

  resources :words
  get 'words/:id/output' => 'words#output'
  get 'words/:id/output/:size' => 'words#output'
  get 'image/random(.:format)' => 'image#random'
  get 'image/:id(.:format)' => 'image#show'
  post 'slack' => 'slack#respond'
end
