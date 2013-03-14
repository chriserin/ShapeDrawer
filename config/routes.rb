ShapeDrawer::Application.routes.draw do
  root :to => 'fonts#index'

  resources :words
  get 'words/:id/output' => 'words#output'
  get 'words/:id/output/:size' => 'words#output'
end
