export default {
  setupComponent(attrs, component) {
    component.set("showMattressPreferences", true);
    
    // Load the existing preference value from the model
    const model = attrs.model;
    if (model && model.custom_fields) {
      component.set("mattressPreferences", model.custom_fields.mattress_preferences);
    }
  },

  actions: {
    save() {
      // Ensure this field is saved by adding it to saveAttrNames
      if (this.saveAttrNames) {
        this.saveAttrNames.pushObject("custom_fields");
      }
    }
  }
};