updateQuantity = (containerInfo, updater) ->
  quantity = containerInfo.find("input[type=hidden]")
  quantity.val((_, value) -> updater(parseInt(value)))
  containerInfo.find(".container-quality").text(quantity.val())

$(document).ready ->
  $(".change-quantity-plus")
      .off()
      .on("click.plus", ->
        updateQuantity($(@).next(".container-info"), (quantity) -> quantity + 1)
        $(@).closest(".supplier-report").find(".notice-supplier").hide('slow')
      )


  $(".change-quantity-minus")
    .off()
    .on("click.minus", ->
      that = $(@)
      notice = true
      updateQuantity(that.prev(".container-info"), (quantity) -> if quantity > 0 then quantity - 1 else quantity)
      $.each($(@).closest(".supplier-report").find(".container-quality"), (indx, obj) ->
        if($(obj).text().trim() != "0")
          notice = false
          return
      )
      if notice
        that.closest(".supplier-report").find(".notice-supplier").show('slow')
    )


  $("a.reason-button")
    .off()
    .on("click", ->
      that = $(@)
      pickup_id = $(@).data("pickup-id")
      sr_id = $(@).data("sr-id")
      reason_id = $(@).data("reason-id")
      url = "/pickups/" + pickup_id + "/not_picked"
      $.ajax({
       url: url
       method: "POST",
       dataType: "json",
       data: {reason_id: reason_id, sr_id: sr_id }
      })
      .done( (data) ->
        $(".supplier-report[data-sr=" + data["sr_id"] + "]").find(".rsvp.reason").text(data.reason)
        $("#noPickup" + data["sr_id"]).foundation('reveal', 'close')
      )
    )
