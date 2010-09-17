/* agent related stuff */
$(document).ready(function(){

  $("#newagentlink").click(function(){
        if ($("#newagentdiv").is(":hidden")) {
          $("#newagentlink").html("Hide");
          $("#newagentdiv").slideDown("slow");
          } else {
          $("#newagentdiv").slideUp();
          $("#newagentlink").html("New Agent");
        }
      });

  $("div[id^='remove-agent']").click(function(){
        // remove agent
        var name = $(this).parent().attr("id");
        var project = $(this).parent().attr("project");
        if (confirm("Delete agent " + name + "?"))
        {
          $.http_delete("/projects/"+project+"/agents/"+name)
          $(this).parent().remove();
        }
      });

});
