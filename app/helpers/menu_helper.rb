# encoding: UTF-8

module MenuHelper

  def render_menu
    c = params[:controller]
    a = params[:action]
    if c == 'settings'
      menu = menu_for_settings
    elsif c == 'laboratory'
      menu = menu_for_laboratory
    elsif c == 'ingredient_parameter_type_ranges' and a == 'index'
      menu = menu_for_ingredient_parameter_type_ranges_index
    elsif c == 'ingredient_parameter_type_ranges' and a == 'show'
      menu = menu_for_ingredient_parameter_type_ranges_show
    elsif c == 'ingredient_parameter_type_ranges' and a == 'edit'
      menu = menu_for_ingredient_parameter_type_ranges_edit
    elsif c == 'product_parameter_type_ranges' and a == 'index'
      menu = menu_for_product_parameter_type_ranges_index
    elsif c == 'product_parameter_type_ranges' and a == 'show'
      menu = menu_for_product_parameter_type_ranges_show
    elsif c == 'product_parameter_type_ranges' and a == 'edit'
      menu = menu_for_product_parameter_type_ranges_edit
    elsif c == 'recipes' and (a == 'edit' or a == 'update' or a == 'clone')
      menu = menu_for_recipes_edit
    elsif c == 'recipes' and a == 'index'
      menu = menu_for_recipes_index
    elsif c == 'recipes' and a == 'show'
      menu = menu_for_recipes_show
    elsif c == 'recipes' and (a == 'new' or a == 'create')
      menu = menu_for_recipes_new
    elsif c == 'recipes' and (a == 'edit' or a == 'update' or a == 'clone')
      menu = menu_for_recipes_edit
    elsif c == 'recipes' and a == 'import'
      menu = menu_for_recipes_import
    elsif c == 'medicament_recipes' and a == 'index'
      menu = menu_for_medicament_recipes_index
    elsif c == 'medicament_recipes' and a == 'show'
      menu = menu_for_medicament_recipes_show
    elsif c == 'medicament_recipes' and (a == 'new' or a == 'create')
      menu = menu_for_medicament_recipes_new
    elsif c == 'medicament_recipes' and (a == 'edit' or a == 'update')
      menu = menu_for_medicament_recipes_edit
    elsif c == 'ingredients' and a == 'index'
      menu = menu_for_ingredients_index
    elsif c == 'ingredients' and a == 'lots'
      menu = menu_for_ingredients_lots
    elsif c == 'ingredients' and (a == 'new' or a == 'create')
      menu = menu_for_ingredients_new
    elsif c == 'ingredients' and (a == 'edit' or a == 'update')
      menu = menu_for_ingredients_edit
    elsif c == 'users' and a == 'index'
      menu = menu_for_users_index
    elsif c == 'users' and (a == 'new' or a == 'create')
      menu = menu_for_users_new
    elsif c == 'users' and (a == 'edit' or a == 'update')
      menu = menu_for_users_edit
    elsif c == 'hoppers' and (a == 'new' or a == 'create')
      menu = menu_for_hoppers_new
    elsif c == 'hoppers' and (a == 'edit' or a == 'update')
      menu = menu_for_hoppers_edit
    elsif c == 'hoppers' and a == 'change'
      menu = menu_for_hoppers_change
    elsif c == 'hoppers' and a == 'fill'
      menu = menu_for_hoppers_fill
    elsif c == 'hoppers' and a == 'adjust'
      menu = menu_for_hoppers_adjust
    elsif c == 'hoppers' and a == 'change_factory_lots' or a == 'do_change_factory_lots'
      menu = menu_for_hoppers_change_factory_lots
    elsif c == 'products' and a == 'index'
      menu = menu_for_products_index
    elsif c == 'products' and (a == 'new' or a == 'create')
      menu = menu_for_products_new
    elsif c == 'products' and (a == 'edit' or a == 'update')
      menu = menu_for_products_edit
    elsif c == 'orders' and a == 'index'
      menu = menu_for_orders_index
    elsif c == 'orders' and a == 'show'
      menu = menu_for_orders_show
    elsif c == 'orders' and (a == 'new' or a == 'create')
      menu = menu_for_orders_new
    elsif c == 'orders' and (a == 'edit' or a == 'update')
      menu = menu_for_orders_edit
    elsif c == 'orders' and a == 'repair'
      menu = menu_for_orders_repair
    elsif c == 'orders' and a == 'notify'
      menu = menu_for_orders_notify
    elsif c == 'clients' and a == 'index'
      menu = menu_for_clients_index
    elsif c == 'clients' and (a == 'new' or a == 'create')
      menu = menu_for_clients_new
    elsif c == 'clients' and (a == 'edit' or a == 'update')
      menu = menu_for_clients_edit
    elsif c == 'order_stat_types' and a == 'index'
      menu = menu_for_order_stat_types_index
    elsif c == 'order_stat_types' and (a == 'new' or a == 'create')
      menu = menu_for_order_stat_types_new
    elsif c == 'order_stat_types' and (a == 'edit' or a == 'update')
      menu = menu_for_order_stat_types_edit
    elsif c == 'factories' and a == 'index'
      menu = menu_for_factories_index
    elsif c == 'factories' and (a == 'new' or a == 'create')
      menu = menu_for_factories_new
    elsif c == 'factories' and (a == 'edit' or a == 'update')
      menu = menu_for_factories_edit
    elsif c == 'batches' and a == 'index'
      menu = menu_for_batches_index
    elsif c == 'batches' and (a == 'new' or a == 'create')
      menu = menu_for_batches_new
    elsif c == 'batches' and (a == 'edit' or a == 'update')
      menu = menu_for_batches_edit
    elsif c == 'lots' and a == 'index'
      menu = menu_for_lots_index
    elsif c == 'lots' and (a == 'new' or a == 'create')
      menu = menu_for_lots_new
    elsif c == 'lots' and (a == 'edit' or a == 'update')
      menu = menu_for_lots_edit
    elsif c == 'lots' and a == 'adjust'
      menu = menu_for_lots_adjust
    elsif c == 'lot_parameter_lists' and a == 'index'
      menu = menu_for_lot_parameter_lists_index
    elsif c == 'lot_parameter_lists' and a == 'show'
      menu = menu_for_lot_parameter_lists_show
    elsif c == 'lot_parameter_lists' and (a == 'edit' or a == 'update')
      menu = menu_for_lot_parameter_lists_edit
    elsif c == 'product_lot_parameter_lists' and a == 'index'
      menu = menu_for_product_lot_parameter_lists_index
    elsif c == 'product_lot_parameter_lists' and a == 'show'
      menu = menu_for_product_lot_parameter_lists_show
    elsif c == 'product_lot_parameter_lists' and (a == 'edit' or a == 'update')
      menu = menu_for_product_lot_parameter_lists_edit
    elsif c == 'schedules' and a == 'index'
      menu = menu_for_schedules_index
    elsif c == 'schedules' and (a == 'new' or a == 'create')
      menu = menu_for_schedules_new
    elsif c == 'schedules' and (a == 'edit' or a == 'update')
      menu = menu_for_schedules_edit
    elsif c == 'transaction_types' and a == 'index'
      menu = menu_for_transaction_types_index
    elsif c == 'transaction_types' and (a == 'new' or a == 'create')
      menu = menu_for_transaction_types_new
    elsif c == 'transaction_types' and (a == 'edit' or a == 'update')
      menu = menu_for_transaction_types_edit
    elsif c == 'product_lots' and a == 'index'
      menu = menu_for_product_lots_index
    elsif c == 'product_lots' and (a == 'new' or a == 'create')
      menu = menu_for_product_lots_new
    elsif c == 'product_lots' and (a == 'edit' or a == 'update')
      menu = menu_for_product_lots_edit
    elsif c == 'product_lots' and a == 'adjust'
      menu = menu_for_product_lots_adjust
    elsif c == 'transactions' and a == 'index'
      menu = menu_for_transactions_index
    elsif c == 'transactions' and (a == 'new' or a == 'create')
      menu = menu_for_transactions_new
    elsif c == 'transactions' and (a == 'edit' or a == 'update')
      menu = menu_for_transactions_edit
    elsif c == 'transactions' and (a == 'export')
      menu = menu_for_transactions_export
    elsif c == 'permissions' and a == 'index'
      menu = menu_for_permissions_index
    elsif c == 'permissions' and (a == 'new' or a == 'create')
      menu = menu_for_permissions_new
    elsif c == 'permissions' and (a == 'edit' or a == 'update')
      menu = menu_for_permissions_edit
    elsif c == 'roles' and a == 'index'
      menu = menu_for_roles_index
    elsif c == 'roles' and (a == 'new' or a == 'create' or a == 'clone')
      menu = menu_for_roles_new
    elsif c == 'roles' and (a == 'edit' or a == 'update')
      menu = menu_for_roles_edit
    elsif c == 'reports' and a == 'index'
      menu = menu_for_reports_index
    elsif c == 'reports' and a == 'weekly_recipes_versions'
      menu = menu_for_reports_weekly_recipes_versions
    elsif c == 'drivers' and a == 'index'
      menu = menu_for_drivers_index
    elsif c == 'drivers' and (a == 'new' or a == 'create')
      menu = menu_for_drivers_new
    elsif c == 'drivers' and (a == 'edit' or a == 'update')
      menu = menu_for_drivers_edit
    elsif c == 'carriers' and a == 'index'
      menu = menu_for_carriers_index
    elsif c == 'carriers' and (a == 'new' or a == 'create')
      menu = menu_for_carriers_new
    elsif c == 'carriers' and (a == 'edit' or a == 'update')
      menu = menu_for_carriers_edit
    elsif c == 'trucks' and a == 'index'
      menu = menu_for_trucks_index
    elsif c == 'trucks' and (a == 'new' or a == 'create')
      menu = menu_for_trucks_new
    elsif c == 'trucks' and (a == 'edit' or a == 'update')
      menu = menu_for_trucks_edit
    elsif c == 'tickets' and a == 'index'
      menu = menu_for_tickets_index
    elsif c == 'tickets' and (a == 'new' or a == 'create')
      menu = menu_for_tickets_new
    elsif c == 'tickets' and (a == 'edit' or a == 'update')
      menu = menu_for_tickets_edit
    elsif c == 'tickets' and (a == 'repair' or a == 'do_repair')
      menu = menu_for_tickets_repair
    elsif c == 'alarm_types' and a == 'index'
      menu = menu_for_alarm_types_index
    elsif c == 'alarm_types' and (a == 'new' or a == 'create')
      menu = menu_for_alarm_types_new
    elsif c == 'alarm_types' and (a == 'edit' or a == 'update')
      menu = menu_for_alarm_types_edit
    elsif c == 'parameter_types' and a == 'index'
      menu = menu_for_parameter_types_index
    elsif c == 'parameter_types' and (a == 'new' or a == 'create')
      menu = menu_for_parameter_types_new
    elsif c == 'parameter_types' and (a == 'edit' or a == 'update')
      menu = menu_for_parameter_types_edit
    elsif c == 'lot_parameter_types' and a == 'index'
      menu = menu_for_lot_parameter_types_index
    elsif c == 'lot_parameter_types' and (a == 'new' or a == 'create')
      menu = menu_for_lot_parameter_types_new
    elsif c == 'lot_parameter_types' and (a == 'edit' or a == 'update')
      menu = menu_for_lot_parameter_types_edit
    elsif c == 'product_lot_parameter_types' and a == 'index'
      menu = menu_for_product_lot_parameter_types_index
    elsif c == 'product_lot_parameter_types' and (a == 'new' or a == 'create')
      menu = menu_for_product_lot_parameter_types_new
    elsif c == 'product_lot_parameter_types' and (a == 'edit' or a == 'update')
      menu = menu_for_product_lot_parameter_types_edit
    elsif c == 'scales' and a == 'index'
      menu = menu_for_scales_index
    elsif c == 'scales' and a == 'show'
      menu = menu_for_scales_show
    elsif c == 'scales' and (a == 'new' or a == 'create')
      menu = menu_for_scales_new
    elsif c == 'scales' and (a == 'edit' or a == 'update')
      menu = menu_for_scales_edit
    end
    return content_tag(:div, menu, :id => 'menu')
  end

  private

  def render_action(caption, title, url, image)
    icon = image_tag(image, :alt=>caption, :title=>title, :height=>28, :width=>28)
    return content_tag(:li, link_to(icon, url))
  end

  def render_function(caption, title, function, image)
    icon = image_tag(image, :alt=>caption, :title=>title, :height=>28, :width=>28)
    return content_tag(:li, link_to(icon, '#', :onclick => function))
  end

  def render_back(url)
    return render_action('Volver', 'Volver', url, 'button-back.png')
  end

  def menu_for_settings
    menu = content_tag(:p, 'Configuración')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_function('Guardar', 'Guardar configuración', "submit_settings_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_laboratory
    menu = content_tag(:p, 'Laboratorio')
    menu += content_tag(:ul,
      render_back(root_path)
    )
    return menu
  end

  def menu_for_ingredient_parameter_type_ranges_index
    menu = content_tag(:p, 'Rango de caracteristicas por materia prima')
    menu += content_tag(:ul,
      render_back(laboratory_path)
    )
    return menu
  end

  def menu_for_ingredient_parameter_type_ranges_show
    menu = content_tag(:p, "Rangos para #{@ingredient.name}")
    menu += content_tag(:ul,
      render_back(session[:return_to]) 
    )
    return menu
  end

  def menu_for_ingredient_parameter_type_ranges_edit
    menu = content_tag(:p, "Editar rangos para #{@ingredient.name}")
    menu += content_tag(:ul,
      render_back(session[:return_to]) + 
      render_function('Guardar', 'Guardar rangos', "submit_ingredient_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_product_parameter_type_ranges_index
    menu = content_tag(:p, 'Rango de caracteristicas por producto terminado')
    menu += content_tag(:ul,
      render_back(laboratory_path)
    )
    return menu
  end

  def menu_for_product_parameter_type_ranges_show
    menu = content_tag(:p, "Rangos para #{@product.name}")
    menu += content_tag(:ul,
      render_back(session[:return_to])
    )
    return menu
  end

  def menu_for_product_parameter_type_ranges_edit
    menu = content_tag(:p, "Editar rangos para #{@product.name}")
    menu += content_tag(:ul,
      render_back(session[:return_to]) +
      render_function('Guardar', 'Guardar rangos', "submit_product_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_recipes_index
    menu = content_tag(:p, 'Recetas')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Importar', 'Importar recetas desde archivo', recipe_import_path, 'button-import.png')+
      render_action('Crear', 'Crear nueva receta', new_recipe_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_recipes_show
    menu = content_tag(:p, 'Detalle de receta')
    menu += content_tag(:ul,
      render_back('javascript:history.back()')
    )
    return menu
  end

  def menu_for_recipes_new
    menu = content_tag(:p, 'Nueva receta')
    menu += content_tag(:ul,
      render_back(recipes_path) +
      render_function('Guardar', 'Guardar receta', "submit_recipe_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_recipes_edit
    menu = content_tag(:p, 'Editar receta')
    menu += content_tag(:ul,
      render_back(recipes_path) +
      render_function('Actualizar', 'Actualizar receta', "submit_recipe_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_recipes_import
    menu = content_tag(:p, 'Importar recetas')
    menu += content_tag(:ul,
      render_back(recipes_path) +
      render_function('Importar', 'Importar recetas', "submit_recipe_upload_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_medicament_recipes_index
    menu = content_tag(:p, 'Recetas de medicamentos')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nueva receta de medicamentos', new_medicament_recipe_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_medicament_recipes_show
    menu = content_tag(:p, 'Detalle de receta de medicamentos')
    menu += content_tag(:ul,
      render_back(medicament_recipes_path) +
      render_action('Editar', 'Editar receta de medicamentos', edit_medicament_recipe_path, 'button-edit.png')
    )
    return menu
  end

  def menu_for_medicament_recipes_new
    menu = content_tag(:p, 'Nueva receta de medicamentos')
    menu += content_tag(:ul,
      render_back(medicament_recipes_path) +
      render_function('Guardar', 'Guardar receta', "submit_medicament_recipe_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_medicament_recipes_edit
    menu = content_tag(:p, 'Editar receta de medicamentos')
    menu += content_tag(:ul,
      render_back(medicament_recipe_path(params[:id])) +
      render_function('Actualizar', 'Actualizar receta de medicamentos', "submit_medicament_recipe_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_ingredients_index
    menu = content_tag(:p, 'Materias primas')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nueva materia prima', new_ingredient_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_ingredients_lots
    menu = content_tag(:p, "Lotes de #{@ingredient.name}")
    menu += content_tag(:ul,
      render_back(ingredients_path)
    )
    return menu
  end

  def menu_for_ingredients_new
    menu = content_tag(:p, 'Nueva materia prima')
    menu += content_tag(:ul,
      render_back(ingredients_path) +
      render_function('Guardar', 'Guardar materia prima', "submit_ingredient_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_ingredients_edit
    menu = content_tag(:p, 'Editar materia prima')
    menu += content_tag(:ul,
      render_back(ingredients_path) +
      render_function('Actualizar', 'Actualizar materia prima', "submit_ingredient_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_users_index
    menu = content_tag(:p, 'Usuarios')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nuevo usuario', new_user_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_users_new
    menu = content_tag(:p, 'Nuevo usuario')
    menu += content_tag(:ul,
      render_back(users_path) +
      render_function('Guardar', 'Guardar usuario', "submit_user_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_users_edit
    menu = content_tag(:p, 'Editar usuario')
    menu += content_tag(:ul,
      render_back(users_path) +
      render_function('Actualizar', 'Actualizar usuario', "submit_user_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_hoppers_new
    menu = content_tag(:p, 'Nueva tolva')
    menu += content_tag(:ul,
      render_back(scale_path(params[:scale_id])) +
      render_function('Guardar', 'Guardar tolva', "submit_hopper_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_hoppers_edit
    menu = content_tag(:p, 'Editar tolva')
    menu += content_tag(:ul,
      render_back(scale_path(params[:scale_id])) +
      render_function('Actualizar', 'Actualizar tolva', "submit_hopper_edit_form()", 'button-execute.png')
    )
    return menu
  end
  def menu_for_hoppers_change
    menu = content_tag(:p, 'Cambiar lote de tolva')
    menu += content_tag(:ul,
      render_back(scale_path(params[:scale_id])) +
      render_function('Cambiar', 'Cambiar lote de tolva', "submit_hopper_change_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_hoppers_fill
    menu = content_tag(:p, 'Llenar tolva')
    menu += content_tag(:ul,
      render_back(scale_path(params[:scale_id])) +
      render_function('Llenar', 'Llenar tolva', "submit_hopper_fill_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_hoppers_adjust
    menu = content_tag(:p, 'Ajustar existencia en tolva')
    menu += content_tag(:ul,
      render_back(scale_path(params[:scale_id])) +
      render_function('Ajustar', 'Ajustar existencia en tolva', "submit_hopper_adjust_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_hoppers_change_factory_lots
    menu = content_tag(:p, 'Editar lotes de tolva por fábrica')
    menu += content_tag(:ul,
      render_back(scale_path(params[:scale_id])) +
      render_function('Guardar', 'Guardar lotes por fábrica', "submit_hopper_change_factory_lots_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_products_index
    menu = content_tag(:p, 'Productos terminados')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nuevo producto terminado', new_product_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_products_new
    menu = content_tag(:p, 'Nuevo producto terminado')
    menu += content_tag(:ul,
      render_back(products_path) +
      render_function('Guardar', 'Guardar producto terminado', "submit_product_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_products_edit
    menu = content_tag(:p, 'Editar producto terminado')
    menu += content_tag(:ul,
      render_back(products_path) +
      render_function('Actualizar', 'Actualizar producto terminado', "submit_product_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_orders_index
    menu = content_tag(:p, 'Órdenes de producción')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nueva orden de producción', new_order_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_orders_show
    menu = content_tag(:p, 'Detalle de orden')
    menu += content_tag(:ul,
      render_back(orders_path) +
      render_action('Generar Reporte', 'Generar Reporte de Orden de Producción', print_order_path, 'button-print.png')
    )
    return menu
  end

  def menu_for_orders_new
    menu = content_tag(:p, 'Crear nueva orden de producción')
    menu += content_tag(:ul,
      render_back(orders_path) +
      render_function('Guardar', 'Guardar orden de producción', "submit_order_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_orders_edit
    menu = content_tag(:p, 'Editar orden de producción')
    menu += content_tag(:ul,
      render_back(orders_path) +
      render_function('Actualizar', 'Actualizar orden de producción', "submit_order_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_orders_repair
    menu = content_tag(:p, 'Reparar orden de producción')
    menu += content_tag(:ul,
      render_back(orders_path) +
      render_function('Reparar', 'Reparar orden de producción', "submit_order_repair_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_orders_notify
    menu = content_tag(:p, 'Notificar consumos de orden de producción')
    menu += content_tag(:ul,
      render_back(orders_path) +
      render_function('Notificar', 'Notificar orden de producción', "submit_order_notify_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_clients_index
    menu = content_tag(:p, 'Clientes')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nuevo cliente', new_client_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_clients_new
    menu = content_tag(:p, 'Nuevo cliente')
    menu += content_tag(:ul,
      render_back(clients_path) +
      render_function('Guardar', 'Guardar cliente', "submit_client_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_clients_edit
    menu = content_tag(:p, 'Editar cliente')
    menu += content_tag(:ul,
      render_back(clients_path) +
      render_function('Actualizar', 'Actualizar cliente', "submit_client_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_order_stat_types_index
    menu = content_tag(:p, 'Tipos de estadísticas')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nuevo tipo de estadística', new_order_stat_type_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_order_stat_types_new
    menu = content_tag(:p, 'Nuevo tipo de estadística')
    menu += content_tag(:ul,
      render_back(order_stat_types_path) +
      render_function('Guardar', 'Guardar cliente', "submit_order_stat_type_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_order_stat_types_edit
    menu = content_tag(:p, 'Editar tipo de estadística')
    menu += content_tag(:ul,
      render_back(order_stat_types_path) +
      render_function('Actualizar', 'Actualizar cliente', "submit_order_stat_type_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_factories_index
    menu = content_tag(:p, 'Maquilas')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nueva maquila', new_factory_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_factories_new
    menu = content_tag(:p, 'Nueva maquila')
    menu += content_tag(:ul,
      render_back(factories_path) +
      render_function('Guardar', 'Guardar maquila', "submit_factory_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_factories_edit
    menu = content_tag(:p, 'Editar maquila')
    menu += content_tag(:ul,
      render_back(factories_path) +
      render_function('Actualizar', 'Actualizar maquila', "submit_factory_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_batches_index
    menu = content_tag(:p, 'Batches')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nuevo batch', new_batche_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_batches_new
    menu = content_tag(:p, 'Nuevo batch')
    menu += content_tag(:ul,
      render_back(batches_path) +
      render_function('Guardar', 'Guardar batch', "submit_batch_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_batches_edit
    menu = content_tag(:p, 'Editar batch')
    menu += content_tag(:ul,
      render_back(batches_path) +
      render_function('Actualizar', 'Actualizar batch', "submit_batch_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_lots_index
    menu = content_tag(:p, 'Lotes de materias primas')
    back = request.referer.nil? ? :lots : request.referer
    menu += content_tag(:ul,
      render_back(back) +
      render_action('Crear', 'Crear nuevo lote', new_lot_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_lots_new
    menu = content_tag(:p, 'Nuevo lote de materia prima')
    back = request.referer.nil? ? :lots : request.referer
    menu += content_tag(:ul,
      render_back(back) +
      render_function('Guardar', 'Guardar lote', "submit_lot_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_lots_edit
    menu = content_tag(:p, 'Editar lote de materia prima')
    back = request.referer.nil? ? :lots : request.referer
    menu += content_tag(:ul,
      render_back(back) +
      render_function('Actualizar', 'Actualizar lote', "submit_lot_edit_form()", 'button-execute.png')
    )
    return menu
  end
  
  def menu_for_lots_adjust
    menu = content_tag(:p, 'Realizar ajuste de existencia')
    menu += content_tag(:ul,
      render_back(lots_path) +
      render_function('Ajustar', 'Ajustar existencia', "submit_lot_adjust_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_lot_parameter_lists_index
    menu = content_tag(:p, 'Características de lotes de materia prima')
    menu += content_tag(:ul,
      render_back(laboratory_path) +
      render_action('Crear', 'Crear nuevo lote', new_lot_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_lot_parameter_lists_show
    menu = content_tag(:p, 'Características de lote de materia prima')
    menu += content_tag(:ul,
      render_back(session[:return_to])
    )
    return menu
  end

  def menu_for_lot_parameter_lists_edit
    menu = content_tag(:p, 'Editar características de lote de materia prima')
    menu += content_tag(:ul,
      render_back(session[:return_to]) +
      render_function('Actualizar', 'Actualizar características', "submit_lot_parameter_list_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_product_lot_parameter_lists_index
    menu = content_tag(:p, 'Características de lotes de producto terminado')
    menu += content_tag(:ul,
      render_back(laboratory_path) +
      render_action('Crear', 'Crear nuevo lote', new_product_lot_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_product_lot_parameter_lists_show
    menu = content_tag(:p, 'Características de lote de producto terminado')
    menu += content_tag(:ul,
      render_back(session[:return_to])
    )
    return menu
  end

  def menu_for_product_lot_parameter_lists_edit
    menu = content_tag(:p, 'Editar características de lote de producto terminado')
    menu += content_tag(:ul,
      render_back(session[:return_to]) +
      render_function('Actualizar', 'Actualizar características', "submit_product_lot_parameter_list_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_schedules_index
    menu = content_tag(:p, 'Turnos')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nuevo turno', new_schedule_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_schedules_new
    menu = content_tag(:p, 'Nuevo turno')
    menu += content_tag(:ul,
      render_back(schedules_path) +
      render_function('Guardar', 'Guardar turno', "submit_schedule_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_schedules_edit
    menu = content_tag(:p, 'Editar turno')
    menu += content_tag(:ul,
      render_back(schedules_path) +
      render_function('Actualizar', 'Actualizar turno', "submit_schedule_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_transaction_types_index
    menu = content_tag(:p, 'Tipos de transacciones')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nuevo tipo de transacción', new_transaction_type_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_transaction_types_new
    menu = content_tag(:p, 'Nuevo tipo de transacción')
    menu += content_tag(:ul,
      render_back(transaction_types_path) +
      render_function('Guardar', 'Guardar tipo de transacción', "submit_transaction_type_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_transaction_types_edit
    menu = content_tag(:p, 'Editar tipo de transacción')
    menu += content_tag(:ul,
      render_back(transaction_types_path) +
      render_function('Actualizar', 'Actualizar tipo de transacción', "submit_transaction_type_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_product_lots_index
    menu = content_tag(:p, 'Lotes de producto terminado')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nuevo lote', new_product_lot_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_product_lots_new
    menu = content_tag(:p, 'Nuevo lote de producto terminado')
    back = request.referer.nil? ? :product_lots : request.referer
    menu += content_tag(:ul,
      render_back(back) +
      render_function('Guardar', 'Guardar lote', "submit_product_lot_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_product_lots_edit
    menu = content_tag(:p, 'Editar lote de producto terminado')
    back = request.referer.nil? ? :product_lots : request.referer
    menu += content_tag(:ul,
      render_back(back) +
      render_function('Actualizar', 'Actualizar lote', "submit_product_lot_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_product_lots_adjust
    menu = content_tag(:p, 'Realizar ajuste de existencia')
    back = request.referer.nil? ? :product_lots : request.referer
    menu += content_tag(:ul,
      render_back(back) +
      render_function('Ajustar', 'Ajustar existencia', "submit_product_lot_adjust_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_transactions_index
    menu = content_tag(:p, 'Transacciones')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nueva transacción', new_transaction_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_transactions_new
    menu = content_tag(:p, 'Nueva transacción')
    menu += content_tag(:ul,
      render_back(transactions_path) +
      render_function('Guardar', 'Guardar transacción', "submit_transaction_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_transactions_edit
    menu = content_tag(:p, 'Editar transacción')
    menu += content_tag(:ul,
      render_back(transactions_path) +
      render_function('Actualizar', 'Actualizar transacción', "submit_transaction_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_transactions_export
    menu = content_tag(:p, 'Exportar consumos')
    menu += content_tag(:ul,
      render_back(transactions_path)
    )
    return menu
  end

  def menu_for_permissions_index
    menu = content_tag(:p, 'Permisos')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nuevo permiso', new_permission_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_permissions_new
    menu = content_tag(:p, 'Nuevo permiso')
    menu += content_tag(:ul,
      render_back(permissions_path) +
      render_function('Guardar', 'Guardar permiso', "submit_permission_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_permissions_edit
    menu = content_tag(:p, 'Editar permiso')
    menu += content_tag(:ul,
      render_back(permissions_path) +
      render_function('Actualizar', 'Actualizar permiso', "submit_permission_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_roles_index
    menu = content_tag(:p, 'Roles')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nuevo rol', new_role_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_roles_new
    menu = content_tag(:p, 'Nuevo rol')
    menu += content_tag(:ul,
      render_back(roles_path) +
      render_function('Guardar', 'Guardar rol', "submit_role_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_roles_edit
    menu = content_tag(:p, 'Editar rol')
    menu += content_tag(:ul,
      render_back(roles_path) +
      render_function('Actualizar', 'Actualizar rol', "submit_role_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_reports_index
    menu = content_tag(:p, 'Reportes')
    menu += content_tag(:ul, render_back(root_path))
    return menu
  end

  def menu_for_reports_weekly_recipes_versions
    menu = content_tag(:p, 'Versiones de receta por semana')
    menu += content_tag(:ul,
      render_back('javascript:history.back()') +
      render_action('Generar PDF', 'Generar reporte en PDF', weekly_recipes_versions_report_path(format: :pdf, utf8: '✓', report: params[:report]), 'button-print.png')
    )
    return menu
  end

  def menu_for_drivers_index
    menu = content_tag(:p, 'Choferes')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nuevo chofer', new_driver_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_drivers_new
    menu = content_tag(:p, 'Nuevo chofer')
    menu += content_tag(:ul,
      render_back(drivers_path) +
      render_function('Guardar', 'Guardar chofer', "submit_driver_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_drivers_edit
    menu = content_tag(:p, 'Editar chofer')
    menu += content_tag(:ul,
      render_back(drivers_path) +
      render_function('Actualizar', 'Actualizar chofer', "submit_driver_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_carriers_index
    menu = content_tag(:p, 'Empresas de transporte')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nueva empresa de transporte', new_carrier_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_carriers_new
    menu = content_tag(:p, 'Nueva empresa de transporte')
    menu += content_tag(:ul,
      render_back(carriers_path) +
      render_function('Guardar', 'Guardar empresa de transporte', "submit_carrier_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_carriers_edit
    menu = content_tag(:p, 'Editar empresa de transporte')
    menu += content_tag(:ul,
      render_back(carriers_path) +
      render_function('Actualizar', 'Actualizar empresa de transporte', "submit_carrier_edit_form()", 'button-execute.png')
    )
    return menu
  end
  
  def menu_for_trucks_index
    menu = content_tag(:p, 'Camiones')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nuevo camión', new_truck_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_trucks_new
    menu = content_tag(:p, 'Nuevo camión')
    menu += content_tag(:ul,
      render_back(trucks_path) +
      render_function('Guardar', 'Guardar camión', "submit_truck_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_trucks_edit
    menu = content_tag(:p, 'Editar camión')
    menu += content_tag(:ul,
      render_back(trucks_path) +
      render_function('Actualizar', 'Actualizar camión', "submit_truck_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_tickets_index
    menu = content_tag(:p, 'Tickets')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nuevo ticket', new_ticket_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_tickets_new
    menu = content_tag(:p, 'Nuevo ticket')
    menu += content_tag(:ul,
      render_back(tickets_path) +
      render_function('Guardar', 'Guardar ticket', "submit_ticket_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_tickets_edit
    menu = content_tag(:p, 'Editar ticket')
    menu += content_tag(:ul,
      render_back(tickets_path) +
      render_function('Actualizar', 'Actualizar ticket', "submit_ticket_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_tickets_repair
    menu = content_tag(:p, 'Reparar ticket')
    menu += content_tag(:ul,
      render_back(tickets_path) +
      render_function('Reparar', 'Reparar ticket', "submit_ticket_repair_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_alarm_types_index
    menu = content_tag(:p, 'Tipos de alarma')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nuevo tipo de alarma', new_alarm_type_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_alarm_types_new
    menu = content_tag(:p, 'Nuevo tipo de alarma')
    menu += content_tag(:ul,
      render_back(alarm_types_path) +
      render_function('Guardar', 'Guardar tipo de alarma', "submit_alarm_type_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_alarm_types_edit
    menu = content_tag(:p, 'Editar tipo de alarma')
    menu += content_tag(:ul,
      render_back(alarm_types_path) +
      render_function('Actualizar', 'Actualizar tipo de alarma', "submit_alarm_type_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_parameter_types_index
    menu = content_tag(:p, 'Tipos de parámetros')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nuevo tipo de parámetro', new_parameter_type_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_parameter_types_new
    menu = content_tag(:p, 'Nuevo tipo de parámetro')
    menu += content_tag(:ul,
      render_back(parameter_types_path) +
      render_function('Guardar', 'Guardar tipo de parámetro', "submit_parameter_type_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_parameter_types_edit
    menu = content_tag(:p, 'Editar tipo de parámetro')
    menu += content_tag(:ul,
      render_back(parameter_types_path) +
      render_function('Actualizar', 'Actualizar tipo de parámetro', "submit_parameter_type_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_lot_parameter_types_index
    menu = content_tag(:p, 'Tipos de características de lote de materia prima')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nuevo tipo de característica', new_lot_parameter_type_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_lot_parameter_types_new
    menu = content_tag(:p, 'Nuevo tipo de característica de lote de materia prima')
    menu += content_tag(:ul,
      render_back(lot_parameter_types_path) +
      render_function('Guardar', 'Guardar tipo de característica', "submit_lot_parameter_type_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_lot_parameter_types_edit
    menu = content_tag(:p, 'Editar tipo de característica de lote de materia prima')
    menu += content_tag(:ul,
      render_back(lot_parameter_types_path) +
      render_function('Actualizar', 'Actualizar tipo de característica de lote', "submit_lot_parameter_type_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_product_lot_parameter_types_index
    menu = content_tag(:p, 'Tipos de características de lote de producto terminado')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Crear nuevo tipo de característica', new_product_lot_parameter_type_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_product_lot_parameter_types_new
    menu = content_tag(:p, 'Nuevo tipo de característica de lote de producto terminado')
    menu += content_tag(:ul,
      render_back(product_lot_parameter_types_path) +
      render_function('Guardar', 'Guardar tipo de característica', "submit_product_lot_parameter_type_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_product_lot_parameter_types_edit
    menu = content_tag(:p, 'Editar tipo de característica de lote de producto terminado')
    menu += content_tag(:ul,
      render_back(product_lot_parameter_types_path) +
      render_function('Actualizar', 'Actualizar tipo de característica de lote', "submit_product_lot_parameter_type_edit_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_scales_index
    menu = content_tag(:p, 'Balanzas y tolvas')
    menu += content_tag(:ul,
      render_back(root_path) +
      render_action('Crear', 'Nueva balanza', new_scale_path, 'button-add.png')
    )
    return menu
  end

  def menu_for_scales_show
    menu = content_tag(:p, "Tolvas de #{@scale.name}")
    menu += content_tag(:ul,
      render_back(scales_path) +
      render_action('Crear', 'Crear nueva tolva', new_scale_hopper_path(@scale), 'button-add.png')
    )
    return menu
  end

  def menu_for_scales_new
    menu = content_tag(:p, 'Nueva balanza')
    menu += content_tag(:ul,
      render_back(scales_path) +
      render_function('Guardar', 'Guardar tipo de parámetro', "submit_scale_new_form()", 'button-execute.png')
    )
    return menu
  end

  def menu_for_scales_edit
    menu = content_tag(:p, 'Editar balanza')
    menu += content_tag(:ul,
      render_back(scales_path) +
      render_function('Actualizar', 'Actualizar balanza', "submit_scale_edit_form()", 'button-execute.png')
    )
    return menu
  end
end
