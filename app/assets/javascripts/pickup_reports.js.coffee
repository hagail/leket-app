updateQuantity = (containerInfo, updater) ->
  quantity = containerInfo.find("input[type=hidden]")
  quantity.val((_, value) -> updater(parseInt(value)))
  containerInfo.find(".container-quality").text(quantity.val())

$(document).ready ->
  $(".change-quantity-plus").click ->
    updateQuantity($(@).next(".container-info"), (quantity) -> quantity + 1)

  $(".change-quantity-minus").click ->
    updateQuantity($(@).prev(".container-info"), (quantity) -> if quantity > 0 then quantity - 1 else quantity)
