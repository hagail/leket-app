// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require best_in_place
//= require foundation
//= require turbolinks
//= require fastclick
//= require_tree .

$(document).foundation();

$(document).ready(function() {
  $(".best_in_place").best_in_place();


  $(".pickup-report .edit").on("click", function(){
    $(this).closest(".pickup-report").removeClass("closed");
  })

  $(".pickup-report .approval").on("click", function(e){

    e.stopPropagation();

    var $this = $(this);
    var $report = $this.closest(".pickup-report");
    var report_id = $this.data("report-id");
      var pickup_id = $this.data("pickup-id");
      $.ajax({
        url: "/pickups/" + pickup_id + "/pickup_reports/" + report_id + "/" + $this.data("approval"),
        method: "POST"
      })
      .done(function(){
         ($this.data("approval") == "unapprove") ? unapproveReport($report) : approveReport($report);
         $report.hide('slow');
         $report.attr("data-approval", $this.data("approval") + "d");
      })
  });


  $(".actions").stick_in_parent();

});


function approveReport(report){
  report.find(".approval.selected").removeClass("selected");
  report.find(".approval.approve").addClass("selected");
}

function unapproveReport(report){
  report.find(".approval.selected").removeClass("selected");
  report.find(".approval.unapprove").addClass("selected");
}
