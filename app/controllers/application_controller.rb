class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email]) # 新規登録時(sign_up時)にnameというキーのパラメーターを追加で許可する
  end
  # 新規登録の際に、nameも入れるようにした。deviseのストロングパラメーターは直接編集できないため、ここに書く。
end
