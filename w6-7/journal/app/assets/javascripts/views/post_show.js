Journal.Views.PostShow = Backbone.View.extend({
  template: JST['post_show'],

  events: {
    'click .delete-button': 'delete'
  },  

  delete: function() {
    this.model.destroy();
    this.remove();
    Backbone.history.navigate('', {trigger: true});
  },

  render: function() {
    var content = this.template({ post: this.model });
    this.$el.html(content);
    return this;
  }
})
