window.Journal = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new Journal.Routers.PostsRouter({ $rootEl: $('div.posts') });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  Journal.initialize();
});
