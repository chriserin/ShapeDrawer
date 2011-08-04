//= require jquery

$(function(){
  $("#output_css").toggle();
  $(".display_scss").click(function(){
    $("#output_css").hide(100);  
    $("#output_scss").show(100);  
    $(".output_display").removeClass("full_width");
  });

  $(".display_css").click(function(){
    $("#output_css").show(100);  
    $("#output_scss").hide(100);  
    $(".output_display").removeClass("full_width");
  });

  $(".display_nothing").click(function(){
    $("#output_css").hide(100);  
    $("#output_scss").hide(100);  
    $(".output_display").addClass("full_width");
  });
});
