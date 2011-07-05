//TODO: Remove this and build the plugin architecture
Dashboard.renderers['com.linkedin'] = {
  render: function(bacn, element){
    var liclass = bacn.headers['X-LinkedIn-Class'];
    if (liclass === "INVITE-MBR") {
      for (var p in bacn.parts) {
        var name = /Accept invitation from (.*)/.exec(bacn.parts[p]);
        if (name) {
          element.find('.name').text(name[1]);
          element.find('.action').text("wants you to join their network");
          break;
        }
      }
    } else {
      element.find('.sender').text(bacn.headers['Subject']);
    }
    return element;
  }
}
