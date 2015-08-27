NewsReader.Collections.Entries = Backbone.Collection.extend({
  model: NewsReader.Models.Entry,
  
  initialize: function (collection, options) {
    this.feed = options.feed;
  },

  url: function () {
    return this.feed.url() + '/entries';
  }

});
