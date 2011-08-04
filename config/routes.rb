ShapeDrawer::Application.routes.draw do
  root :to => 'fonts#index'

  resources :words
  match 'words/:id/output' => 'words#output'
  match 'words/:id/output/:size' => 'words#output'
end
