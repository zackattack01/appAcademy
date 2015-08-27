NewsReader.Views.FeedIndex = Backbone.View.extend({
  template: JST['feed_index'],

  tagName: 'ul',

  initialize: function () {
    this.listenTo(this.collection, 'sync', this.render);
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    var that = this;
    this.collection.each(function (feed) {
      var view = new NewsReader.Views.FeedIndexItem({ model: feed });
      that.$el.append(view.render().$el);
    });
    return this;
  }
});
