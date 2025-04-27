# name: tmu-discourse-plugin
# about: A plugin for TMU users to show their mattress preferences. 
# version: 0.0.1
# authors: Arifur Rahman
# url: https://github.com/arifur/tmu-discourse-plugin.git

enabled_site_setting :tmu_discourse_plugin_enabled

after_initialize do
  require_dependency 'user'
  require_dependency 'users_controller'
  
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
  
  # Whitelist mattress_preferences in the UsersController
  UsersController.class_eval do
    alias_method :original_update, :update

    def update
      if params[:user].present? && params[:user][:custom_fields].present?
        custom_fields = params[:user][:custom_fields]
        if custom_fields.key?('mattress_preferences')
          @user.custom_fields['mattress_preferences'] = custom_fields['mattress_preferences']
          @user.save_custom_fields(true)
        end
      end
      original_update
    end
  end
end

