updateQuantity = (containerInfo, updater) ->
  quantity = containerInfo.find("input[type=hidden]")
  quantity.val((_, value) -> updater(parseInt(value)))
  containerInfo.find(".container-quality").text(quantity.val())

$(document).ready ->
  $(".change-quantity-plus")
      .off()
      .on("click.plus", ->
    updateQuantity($(@).next(".container-info"), (quantity) -> quantity + 1)
  )

  $(".change-quantity-minus")
      .off()
      .on("click.minus", ->
    updateQuantity($(@).prev(".container-info"), (quantity) -> if quantity > 0 then quantity - 1 else quantity)
  )
