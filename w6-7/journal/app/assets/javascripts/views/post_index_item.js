Journal.Views.PostIndexItem = Backbone.View.extend({
  initialize: function() {
    this.listenTo(this.model, 'remove', this.render);
  },

  template: JST['post_index_item'],

  tagName: 'li',

  events: {
    'click .delete-button': 'removePost'
  },

  render: function() {
    var view = this.template({ post: this.model })
    this.$el.html(view);
    return this;
  },

  removePost: function() {
    this.model.destroy();
    this.remove();
  }

});