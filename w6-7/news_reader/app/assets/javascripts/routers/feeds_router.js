NewsReader.Routers.Feeds = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.rootEl;
    this.collection = options.collection;
  },

  routes: {
    '': 'index',
    'feeds/new': 'newFeed',
    'feeds/:id': 'feedShow'
  },

  index: function () {
    var collection = this.collection;
    collection.fetch();
    var view = new NewsReader.Views.FeedIndex({ collection: collection });
    this._swap(view);
  },

  newFeed: function () {
    var model = new NewsReader.Models.Feed();
    var view = new NewsReader.Views.FeedForm({ model: model, collection: this.collection });
    this._swap(view);
  },

  feedShow: function (id) {
    var model = this.collection.getOrFetch(id);
    var view = new NewsReader.Views.FeedShow({ model: model });
    this._swap(view);
  },

  _swap: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
});
