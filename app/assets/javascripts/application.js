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
//= require jquery_ujs
//= require best_in_place
//= require foundation
//= require fastclick
//= require_tree .

$(document).foundation();

$(document).ready(function() {

  $('#summary_table').DataTable({
   "destroy": true,
    "paging": false,
    "info": false,
    "oLanguage": {
         "sSearch": "חיפוש"
       }
  });

  $("#searchbox").on("keyup search input paste cut", function() {
     $('#summary_table').DataTable().search(this.value).draw();
  });

  $(".best_in_place").best_in_place();


  $(".pickup-report .edit").on("click", function(){
    $(this).closest(".pickup-report").removeClass("closed");
  })

  var approvedMouseenterHandle = function(){
   var $button = $(this);
   $button.css('background', 'red');
   $button.text('פסול')
   $button.on('mouseleave', approvedMouseleaveHandle);
   $button.on('mouseenter', approvedMouseenterHandle);
  }

  var approvedMouseleaveHandle = function(){
   var $button = $(this);
   $button.css('background', '');
   $button.text('מאושר')
  }

  var unapprovedMouseenterHandle = function(){
   var $button = $(this);
   $button.css('background', 'green');
   $button.text('אישור');
   $button.on('mouseleave', unapprovedMouseleaveHandle);
   $button.on('mouseenter', unapprovedMouseenterHandle);
  }

  var unapprovedMouseleaveHandle = function(){
   var $button = $(this);
   $button.css('background', '');
   $button.text('פסול')
  }

  $(".modify_approval[data-approved='true']").mouseenter(approvedMouseenterHandle)
                                             .mouseleave(approvedMouseleaveHandle);

  $(".modify_approval[data-approved='false']").mouseenter(unapprovedMouseenterHandle)
                                              .mouseleave(unapprovedMouseleaveHandle);

  $(".approve_all").on("click", function(e){
   e.stopPropagation();
   e.preventDefault();
   $(".pickup-report.unapproved").each(function(){
    var report = $(this);
    var report_id = report.data("report-id");
    var container_id = report.data("container-report-id");

    $.ajax({
      url: "/container_reports/" + container_id + "/" + "approve",
      method: "POST"
    })
    .done(function(){
      approveReport(report);
      var $button = report.find(".modify_approval");
      $button.on('mouseenter', approvedMouseenterHandle);
    })
   })
  })

  $(".pickup-report .modify_approval").on("click", function(e){
    e.stopPropagation();

    var $button = $(this);
    $button.off('mouseleave');
    var $report = $button.closest(".pickup-report");
    var report_id = $report.data("report-id");
    var container_id = $report.data("container-report-id");
    var pickup_id = $report.data("pickup-id");
    var approval = $button.attr("data-approved") == "true" ? "unapprove" : "approve"

    $.ajax({
      url: "/container_reports/" + container_id + "/" + approval,
      method: "POST"
    })
    .done(function(){
       if (approval == "unapprove") {
        unapproveReport($report)
        $button.on('mouseenter', unapprovedMouseenterHandle);
        $report.addClass('unapproved');
       }
       else{
        approveReport($report);
        $button.on('mouseenter', approvedMouseenterHandle);
       }
    })
  });
});

function unapproveReport(report){
 var button = report.find(".modify_approval");
 button.attr("data-approved", "false");
 button.text("פסול");
 button.css('background','');
}

function approveReport(report){
 var button = report.find(".modify_approval");
 button.attr("data-approved", "true");
 button.text("מאושר");
 button.css('background','');
 report.removeClass('unapproved');
}
