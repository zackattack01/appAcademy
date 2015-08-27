NewsReader.Views.FeedShow = Backbone.View.extend({
  template: JST['feed_show'],

  events: {
    'click .refresh': 'refreshFeed'
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  gatherEntries: function () {
    var $ul = $('<ul></ul>');
    this.model.entries().each(function (entry) {
      var view = new NewsReader.Views.Entry({ model: entry });
      $ul.append(view.render().$el);
    });
    return $ul;
  },

  render: function () {
    var content = this.template({ feed: this.model });
    this.$el.html(content);
    this.$el.append(this.gatherEntries());
    return this;
  },

  refreshFeed: function (e) {
    this.model.fetch();
  }
});
