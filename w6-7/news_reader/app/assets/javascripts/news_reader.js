window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var $rootEl = $("#content");
    var feeds = new NewsReader.Collections.Feeds();
    new NewsReader.Routers.Feeds({rootEl: $rootEl, collection: feeds });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
