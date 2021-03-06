function recipeSelected() {
    select = $('#order_product_lot_id');
    select.empty();
    $.each(product_lots, function(_, product_lot) {
      select.append(new Option(product_lot.to_collection_select, product_lot.id));
    });
    select.trigger("chosen:updated");
    update_product_lot_comment();
}

function hideProductLots() {
  if ($("#order_auto_product_lot").is(":checked"))
    $("#order_product_lot_id_chosen").hide();
  else
    $("#order_product_lot_id_chosen").show();
}

function update_product_lots() {
  var params = {};
  params["recipe_id"] = $("#order_recipe_id").val();
  if ($("#client_type_factory").is(":checked")) {
    params["factory_id"] = $("#order_client_id").val();
  }
  $.getJSON(
    "/product_lots/by_recipe",
    params,
    function(data) {
      product_lots = data;
      recipeSelected();
    }
  );
}

function update_product_lot_comment() {
  var product_lot_id = $("#order_product_lot_id").val();
  var product_comment_div = $("#product_lot_comment")
  product_comment_div.text("")
  if (product_lot_id !== null) {
    $.getJSON(
      "/product_lots/" + product_lot_id,
      function(product_lot) {
        var comment = ""
        if (product_lot.comment !== null) {
          comment = product_lot.comment;
        }
        product_comment_div.text(comment);
      }
    );
  }
}
