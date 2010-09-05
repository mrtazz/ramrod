/* agent related stuff */
$(document).ready(function(){

  var template = '<form action="/projects/{{projectname}}/agents/new" method="post">\
      <label class="formlabel agents" for="agentname">Name: </label><br> \
      <input type="text" \
            class="forminput" \
            id="agentname" \
            name="agentname" \
            value="{{agentname}}"><br> \
      <label class="formlabel agents" for="description">Description: </label><br> \
      <input type="text" \
            class="forminput" \
            id="description" \
            name="description" \
            value="{{description}}"><br> \
      <label class="formlabel agents" for="callback">Token: </label><br> \
      <input type="text" \
            class="forminput" \
            id="callback" \
            name="token" \
            value="{{callback}}"><br> \
      <label class="formlabel agents" for="agenturl">URL: </label><br> \
      <input type="text" \
            class="forminput" \
            id="agenturl" \
            name="agenturl" \
            value="{{agenturl}}"><br> \
      <input type="submit" value="Save"> <input type="reset"></form>';

  //var view = $.get('/projects/'+$project+'/agents');
  var name = $("#projectname").attr("value");
  var view = {projectname: name };

  $("#newagentlink").click(function(){
        alert(view);
        $("#newagentdiv").html($.mustache(template, view));
      });

});
