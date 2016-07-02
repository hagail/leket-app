updateQuantity = (containerInfo, updater) ->
  quantity = containerInfo.find("input[type=hidden]")
  quantity.val((_, value) -> updater(parseInt(value)))
  containerInfo.find(".container-quality").text(quantity.val())

resetPicked = (pickup_id, sr_id) ->
  url = "/pickups/" + pickup_id + "/picked"
  $.ajax({
   url: url
   method: "POST",
   dataType: "json",
   data: { sr_id: sr_id }
  })


$(document).ready ->
  $(".change-quantity-plus")
      .off()
      .on("click.plus", ->
        updateQuantity($(@).next(".container-info"), (quantity) -> quantity + 1)
        sr = $(@).closest(".supplier-report")
        notice = sr.find(".notice-supplier")
        if notice.is(":visible")
          notice.hide('slow')
          pickup_id = sr.data("pu-id")
          sr_id = sr.data("sr")
          resetPicked(pickup_id, sr_id)
          sr.find(".rsvp.reason").text(" בחר/י סיבה לאי-איסוף")
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
       sr = that.closest(".supplier-report")
       pickup_id = sr.data("pu-id")
       sr_id = sr.data("sr")
       sr.find(".notice-supplier").show('slow')
       resetPicked(pickup_id, sr_id)
       sr.find(".rsvp.reason").text(" בחר/י סיבה לאי-איסוף")
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
       data: { reason_id: reason_id, sr_id: sr_id }
      })
      .done( (data) ->
        $(".supplier-report[data-sr=" + data["sr_id"] + "]").find(".rsvp.reason").text(data.reason)
        $("#noPickup" + data["sr_id"]).foundation('reveal', 'close')
      )
    )
