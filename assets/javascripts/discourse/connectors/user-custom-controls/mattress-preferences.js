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
    saveMattressPreferences() {
      const model = this.get("args.model");
      if (!model.custom_fields) {
        model.set("custom_fields", {});
      }
      
      // Ensure the mattress_preferences is saved to the model
      const value = this.get("mattressPreferences");
      model.set("custom_fields.mattress_preferences", value);
      
      // Make sure Discourse knows this field should be saved
      if (model.save) {
        model.save(["custom_fields"]);
      }
    }
  }
}