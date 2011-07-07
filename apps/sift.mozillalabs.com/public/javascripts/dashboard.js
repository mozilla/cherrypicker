var Dashboard = {
  renderers: {},
  processBacn: function(data){
    $.each(data, function(index, value){
      var headers = {};
      $.each(value['bacn']['headers'], function(index, header){
        if (headers[header.name] != null){
          if (typeof(headers[header.name]) == 'string'){
            headers[header.name] = [headers[header.name], header.value];
          }
          else{
            headers[header.name].push(header.value);
          }
        }
        else {
          headers[header.name] = header.value;
        }
      });
      
      var parts = {};

      $.each(value['bacn']['mime_parts'], function(index, part){
        parts[part['content_type']] = part['body'];
      });
      
      var source = value['bacn']['source'];
      console.log('.' + source.replace(/\./g, '_') + '_Template');
      var template = $('#dashboard_templates .' + source.replace(/\./g, '_') + '_Template')
        .clone()
        .removeClass(source.replace(/\./g, '_') + '_Template');

      if (Dashboard.renderers[source]) {
        var e = Dashboard.renderers[source].render({
            'id': value['bacn']['id'],
            'parts': parts,
            'headers': headers
          },
          template
        );
        $('#bacn_list').append(e);
      }

    });
  }
}

$(function(){
  // Load all the bacn.
  $.ajax({
    url: "/bacn",
    success: Dashboard.processBacn,
    error: function(a,b,c){console.log([a,b,c])}
  });
});
