Mango::Application.routes.draw do

  match 'ingredients/search' => "ingredients#search", :via => :get, :as => 'ingredient_search'
  match 'ingredients/catalog' => "ingredients#catalog", :via => :get, :as => 'ingredient_catalog'
  match 'ingredients/select' => "ingredients#select", :via => :get, :as => 'ingredient_select'
  match 'recipes/:id/clone' => "recipes#clone", :via => :get, :as => 'clone_recipe'
  match 'recipes/import' => "recipes#import", :via => :get, :as => 'recipe_import'
  match 'recipes/upload' => "recipes#upload", :via => :post, :as => 'recipe_upload'
  match 'recipes/:id/create_parameter_list' => "recipes#create_parameter_list", :via => :get, :as => 'recipe_create_parameter_list'
  match 'lot_parameter_lists/:lot_id/create' => "lot_parameter_lists#create", :via => :post, :as => 'create_lot_parameter_list'
  match 'product_lot_parameter_lists/:product_lot_id/create' => "product_lot_parameter_lists#create", :via => :post, :as => 'create_product_lot_parameter_list'
  match 'ingredients/:id/lots' => "ingredients#lots", :via => :get, :as => 'ingredient_lots'
  match 'ingredients/get_all' => "ingredients#get_all", via: :get
  match 'products/get_all' => "products#get_all", via: :get
  match 'ingredient_parameter_type_ranges/:id/create' => "ingredient_parameter_type_ranges#create", :via => :post, :as => 'create_ingredient_parameter_type_range'
  match 'product_parameter_type_ranges/:id/create' => "product_parameter_type_ranges#create", :via => :post, :as => 'create_product_parameter_type_range'
  match 'laboratory' => "laboratory#index", :via => :get, :as => 'laboratory'
  match 'recipes/:id/deactivate' => "recipes#deactivate", :via => :get, :as => 'deactivate_recipe'
  match 'roles/:id/clone' => "roles#clone", :via => :get, :as => 'clone_role'
  match 'tickets/:id/print' => "tickets#print", :via => :get, :as => 'print_ticket'
  match 'tickets/:id/notify' => "tickets#notify", :via => :get#, :as => 'notify_ticket'
  match 'tickets/:id/notify' => "tickets#do_notify", :via => :post, :as => "notify_ticket"
  match 'orders/:id/repair' => "orders#repair", :via => :get#, :as => 'repair_order'
  match 'orders/:id/repair' => "orders#do_repair", :via => :put, :as => 'repair_order'
  match 'orders/:id/print' => "orders#print", :via => :get, :as => 'print_order'
  match 'orders/:id/generate_transactions' => "orders#generate_transactions", :via => :put, :as => 'generate_transactions_order'
  match 'orders/generate_consumption' => "orders#generate_consumption", :via => :post, :as => 'generate_consumption_order'
  match 'orders/generate_not_weighed_consumptions' => "orders#generate_not_weighed_consumptions", :via => :post, :as => 'generate_not_weighed_consumptions_order'
  match 'orders/consumption_exists' => "orders#consumption_exists", :via => :get, :as => 'order_consumption_exists'
  match 'orders/close' => "orders#close", :via => :post, :as => 'order_close'
  match 'orders/create_order_stat' => "orders#create_order_stat", :via => :post, :as => 'create_order_stat'
  match 'orders/update_order_area' => "orders#update_order_area", :via => :post, :as => 'update_order_area'
  match 'orders/:id/notify' => "orders#notify", :via => :get#, :as => 'notify_order'
  match 'orders/:id/notify' => "orders#do_notify", :via => :post, :as => 'notify_order'
  match 'orders/open' => "orders#open", :via => :get, :as => 'open_orders'
  match 'orders/validate' => "orders#validate", :via => :get, :as => 'validate_order'
  match 'sessions/not_implemented' => "sessions#not_implemented", :via => :get, :as => "not_implemented"
  match 'lots/:id/adjust' => "lots#adjust", :via => :get#, :as => 'adjust_lot'
  match 'lots/:id/adjust' => "lots#do_adjust", :via => :put, :as => 'adjust_lot'
  match 'lots/get_all' => "lots#get_all", :via => :get
  match 'product_lots/:id/adjust' => "product_lots#adjust", :via => :get#, :as => 'adjust_product_lot'
  match 'product_lots/:id/adjust' => "product_lots#do_adjust", :via => :put, :as => 'adjust_product_lot'
  match 'product_lots/get_all' => "product_lots#get_all", :via => :get
  match 'product_lots/by_recipe' => "product_lots#by_recipe", :via => :get
  match 'parameter_lists/:id/clone' => "parameter_lists#clone", :via => :get, :as => "parameter_list_clone"
  match 'scales/:scale_id/hoppers/:id/set_as_main_hopper' => "hoppers#set_as_main_hopper", :via => :get, :as => "set_as_main_hopper"
  match 'scales/:scale_id/hoppers/:id/fill' => "hoppers#do_fill", :via => :post
  match 'scales/:scale_id/hoppers/:id/change' => "hoppers#do_change", :via => :post
  match 'scales/:scale_id/hoppers/:id/adjust' => "hoppers#do_adjust", :via => :post
  match 'scales/:scale_id/hoppers/:id/change_factory_lots' => "hoppers#do_change_factory_lots", :via => :put
  match 'scales/hoppers_ingredients' => "scales#hoppers_ingredients", :via => :get
  match 'settings.json' => "settings#show", via: :get
  match 'settings/features.json' => "settings#features", via: :get
  match 'settings' => "settings#edit", :via => :get, :as => "settings"
  match 'settings' => "settings#update", :via => :put
  match 'clients/all' => "clients#all", :via => :get
  match 'batches/:batch_id/batches_hopper_lot' => "batches_hopper_lot#create", :via => :post, :as => "batches_hopper_lot"
  match 'batches/:batch_id/batches_hopper_lot/:id' => "batches_hopper_lot#destroy", :via => :delete, :as => "batch_hopper_lot"
  match 'tickets/:id/repair' => "tickets#repair", :via => :get, :as => "repair_ticket"
  match 'tickets/:id/do_repair' => "tickets#do_repair", :via => :post, :as => "do_repair_ticket"
  match 'tickets/new' => "tickets#create", :via => :post, :as => "create_ticket"

  # Reports
  match 'reports' => "reports#index", :via => :get, :as => "reports"
  match 'reports/recipes' => "reports#recipes", :via => :post, :as => "recipes_report"
  match 'reports/daily_production' => "reports#daily_production", :via => :post, :as => "daily_production_report"
  match 'reports/daily_production_details' => "reports#daily_production_details", :via => :post, :as => "daily_production_details_report"
  match 'reports/real_production' => "reports#real_production", :via => :post, :as => "real_production_report"
  match 'reports/order_duration' => "reports#order_duration", :via => :post, :as => "order_duration_report"
  match 'reports/order_details' => "reports#order_details", :via => :post, :as => "order_details_report"
  match 'reports/order_details_real' => "reports#order_details_real", :via => :post, :as => "order_details_real_report"
  match 'reports/batch_details' => "reports#batch_details", :via => :post, :as => "batch_details_report"
  match 'reports/consumption_per_recipe' => "reports#consumption_per_recipe", :via => :post, :as => "consumption_per_recipe_report"
  match 'reports/consumption_per_selected_ingredients' => "reports#consumption_per_selected_ingredients", :via => :post, :as => "consumption_per_selected_ingredients_report"
  match 'reports/consumption_per_ingredients' => "reports#consumption_per_ingredients", :via => :post, :as => "consumption_per_ingredients_report"
  match 'reports/consumption_per_ingredient_per_orders' => "reports#consumption_per_ingredient_per_orders", :via => :post, :as => "consumption_per_ingredient_per_orders_report"
  match 'reports/consumption_per_client' => "reports#consumption_per_client", :via => :post, :as => "consumption_per_client_report"
  match 'reports/stock_adjustments' => "reports#stock_adjustments", :via => :post, :as => "stock_adjustments_report"
  match 'reports/lots_incomes' => "reports#lots_incomes", :via => :post, :as => "lots_incomes_report"
  match 'reports/simple_stock' => "reports#simple_stock", :via => :post, :as => "simple_stock_report"
  match 'reports/simple_stock_projection' => "reports#simple_stock_projection", :via => :post, :as => "simple_stock_projection_report"
  match 'reports/ingredients_stock' => "reports#ingredients_stock", :via => :post, :as => "ingredients_stock_report"
  match 'reports/products_stock' => "reports#products_stock", :via => :post, :as => "products_stock_report"
  match 'reports/product_lots_dispatches' => "reports#product_lots_dispatches", :via => :post, :as => "product_lots_dispatches_report"
  match 'reports/tickets_transactions' => "reports#tickets_transactions", :via => :post, :as => "tickets_transactions_report"
  match 'reports/production_per_recipe' => "reports#production_per_recipe", :via => :post, :as => "production_per_recipe_report"
  match 'reports/production_per_client' => "reports#production_per_client", :via => :post, :as => "production_per_client_report"
  match 'reports/alarms' => "reports#alarms", :via => :post, :as => "alarms_report"
  match 'reports/alarms_per_order' => "reports#alarms_per_order", :via => :post, :as => "alarms_per_order_report"
  match 'reports/stats' => "reports#stats", :via => :post, :as => "stats_report"
  match 'reports/stats_with_plot' => "reports#stats_with_plot", :via => :post, :as => "stats_with_plot_report"
  match 'reports/order_stats' => "reports#order_stats", :via => :post, :as => "order_stats_report"
  match 'reports/hopper_transactions' => "reports#hopper_transactions", :via => :post, :as => "hopper_transactions_report"
  match 'reports/order_lots_parameters' => "reports#order_lots_parameters", :via => :post, :as => "order_lots_parameters_report"
  match 'reports/lot_transactions' => "reports#lot_transactions", :via => :post, :as => "lot_transactions_report"
  match 'reports/weekly_recipes_versions' => 'reports#weekly_recipes_versions', via: :get, as: 'weekly_recipes_versions_report'
  match 'reports/production_and_ingredient_distribution' => 'reports#production_and_ingredient_distribution', via: :post, as: 'production_and_ingredient_distribution_report'
  match 'reports/ingredient_consumption_with_plot' => 'reports#ingredient_consumption_with_plot', via: :post, as: 'ingredient_consumption_with_plot_report'
  match 'reports/sales' => 'reports#sales', via: :post, as: 'sales_report'
  match 'reports/production_note' => 'reports#production_note', via: :post, as: 'production_note_report'
  resources :sessions, :users, :ingredients, :clients, :factories, :products, :orders, :lots, :schedules, :batches,
    :transaction_types, :product_lots, :permissions, :drivers, :carriers, :trucks, :alarm_types, :parameter_types, :order_stat_types,
    :lot_parameter_types, :product_lot_parameter_types, :ingredient_parameter_type_ranges, :product_parameter_type_ranges
  resources :transactions, only: [:index, :new, :create]
  resources :alarms, only: [:create]
  resources :document_types, only: [:index]
  resources :tickets

  resources :recipes do
    resources :ingredients_recipes
  end

  resources :medicament_recipes do
    resources :ingredients_medicament_recipes
  end

  resources :parameter_lists do
    resources :parameters
  end

  resources :lot_parameter_lists do
    resources :lot_parameters
  end

  resources :product_lot_parameter_lists do
    resources :product_lot_parameters
  end

  resources :roles do
    resources :permissions_roles
  end

  resources :scales do
    resources :hoppers do
      member do
        get 'change'
        get 'fill'
        get 'adjust'
        get 'change_factory_lots'
      end
    end
  end

  root :to => "sessions#index"

  match "/sessions/show" => "sessions#show", via: :get, as: 'dashboard'
end
