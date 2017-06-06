
export default Ember.Controller.extend({
  visible:false,

  actions: {
    show(){
      this.set('visible', true);
      const model = this.get('model');
      console.log(model);
      model.pushObject( {text: "Create Zendesk Ticket", title: "Click to create a new Ticket in Zendesk", exists: false} );
    }
  }
});
