# name: tmu-discourse-plugin
# about: A plugin for TMU users to show their mattress preferences. 
# version: 0.0.1
# authors: Arifur Rahman
# url: https://github.com/arifur/tmu-discourse-plugin.git

enabled_site_setting :tmu_discourse_plugin_enabled

after_initialize do
  require_dependency 'user'
  
  # Add mattress_preferences as a custom user field
  User.register_custom_field_type('mattress_preferences', :text)
  
  # Add mattress_preferences to the list of allowed user custom fields
  DiscoursePluginRegistry.serialized_current_user_fields << "mattress_preferences"
  
  # Make sure custom fields are included when serializing the UserSerializer
  add_to_serializer(:user, :custom_fields, false) do
    if object.custom_fields == nil
      {}
    else
      object.custom_fields
    end
  end
  
  # Whitelist mattress_preferences for edits
  register_editable_user_custom_field(:mattress_preferences)
end

