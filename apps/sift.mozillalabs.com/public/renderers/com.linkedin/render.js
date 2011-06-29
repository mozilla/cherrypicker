//TODO: Remove this and build the plugin architecture
Dashboard.renderers['com.linkedin'] = {
  render: function(bacn, element){
    element.find('h1').text(bacn.headers['Subject']);
    return element;
  }
}
