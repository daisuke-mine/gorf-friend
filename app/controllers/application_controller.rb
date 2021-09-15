class ApplicationController < ActionController::Base

    before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
      if current_client
        flash[:notice] = "ログインに成功しました"
        root_url clients_path
      else current_admin
        root_url admins_clients_path
      end
    end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :kana_name, :gender, :age])
    devise_parameter_sanitizer.permit(:account_update, keys: %i(name uid image provider))
  end
end
