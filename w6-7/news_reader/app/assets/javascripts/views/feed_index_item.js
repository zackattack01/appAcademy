NewsReader.Views.FeedIndexItem = Backbone.View.extend({
  template: JST['feed_index_item'],

  tagName: 'li',

  events: {
    "click .delete": "deleteFeed"
  },

  render: function () {
    var content = this.template({ feed: this.model });
    this.$el.append(content);
    return this;
  },

  deleteFeed: function () {
    this.model.destroy();
    this.remove();
  }
});
