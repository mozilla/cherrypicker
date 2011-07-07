//TODO: Remove this and build the plugin architecture
Dashboard.renderers['com.twitter.postmaster'] = {
  render: function(bacn, element){
    var senderhandle = bacn.headers['X-Twittersenderscreenname'];
    var sendername = bacn.headers['X-Twittersendername'];
    var subject = bacn.headers['Subject'];
    var created = new Date(Date.parse(bacn.headers['X-Twittercreatedat'])); // Wed Jun 22 19:03:19 +0000 2011

    element.find('.name').text(sendername);
    element.find('.handle').text(senderhandle);

    if (bacn.headers['X-Twitteremailtype'] === "is_following") {
      element.find('.action').text("is following you");
    } else if (/.*mentioned.*/.test(subject)) {
      element.find('.action').text("mentioned you");
      var regex = new RegExp('@'+senderhandle+':(.*)');
      console.log(regex);
      for (var p in bacn.parts) {
        var message = regex.exec(bacn.parts[p]);
        if (message) {
          element.find('.message').text(message[1]);
        }
      }
    }

    return element;
  }
}
