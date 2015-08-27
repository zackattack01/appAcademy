Journal.Views.PostIndex = Backbone.View.extend({
  initialize: function() {
    this.listenTo(this.collection, 'reset', this.render);
    this.listenTo(this.collection, 'change', this.render);
    this.listenTo(this.collection, 'add', this.render);
    this.listenTo(this.collection, 'remove', this.render);
  },

  template: JST['post_index'],

  tagName: 'ul',

  events: {
    'click button.create-post': 'redirectToCreateForm'
  },

  redirectToCreateForm: function() {
    Backbone.history.navigate('/posts/new', {trigger: true});
  },

  render: function() {
    var viewContent = this.template();
    this.$el.html(viewContent);
    var that = this;
    this.collection.fetch();
    this.collection.each(function(post) {
      var itemView = new Journal.Views.PostIndexItem({ model: post });
      that.$el.append(itemView.render().$el);
    });
    return this;
  }
})