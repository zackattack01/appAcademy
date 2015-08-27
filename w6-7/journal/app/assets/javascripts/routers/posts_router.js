Journal.Routers.PostsRouter = Backbone.Router.extend({
  initialize: function(options) {
    this.$rootEl = options.$rootEl;
    this.collection = new Journal.Collections.Posts();
    this.$contentEl = $('.content');
    this.$sidebar = $('.sidebar');
    this.collection.fetch({ reset: true });
    var view = new Journal.Views.PostIndex({ collection: this.collection })
    this.$sidebar.html(view.render().$el);
  },

  routes: {
    "posts/new": 'newPostForm',
    "posts/:id/edit" : 'editPost',
    "posts/:id" : "showPost",
    "": "root"
  },

  root: function() {
    this._oldView && this._oldView.remove();
  },

  showPost: function(postId) {
    var post = this.collection.getOrFetch(postId);
    var view = new Journal.Views.PostShow({ model: post });
    this.swap(view);
  },

  editPost: function(postId) {
    var post = this.collection.getOrFetch(postId);
    var view = new Journal.Views.PostForm({ model: post, collection: this.collection });
    this.swap(view);
  },

  newPostForm: function() {
    var post = new Journal.Models.Post();
    var view = new Journal.Views.PostForm({ model: post, collection: this.collection });
    this.swap(view);
  },

  swap: function(view) {
    this._oldView && this._oldView.remove();
    this._oldView = view;
    this.$contentEl.html(view.render().$el);
  }
})