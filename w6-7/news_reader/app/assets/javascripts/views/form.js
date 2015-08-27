NewsReader.Views.FeedForm = Backbone.View.extend({
  template: JST['form'],

  events: {
    'submit form': 'createFeed'
  },

  createFeed: function (e) {
    e.preventDefault();
    // debugger;
    var attrs = $(e.target).serializeJSON();
    var that = this;
    debugger;
    that.model.save(attrs, {
      success: function () {
        that.collection.add(that.model);
        Backbone.history.navigate('#/feeds/' + that.model.id, { trigger: true });
      }
    });
  },

  render: function () {
    var feed = new NewsReader.Models.Feed();
    var content = this.template({ feed: feed });
    this.$el.html(content);
    return this;
  }
});
