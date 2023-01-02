class ApplicationController < ActionController::Base
  include Pagy::Backend  
  
  before_action :set_current_user
  before_action :protect_pages
  before_action :set_locale
    
    def extract_locale
        parsed_locale = request.host.split('.').last
        I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
        end
    
    
    private
    def set_locale
      I18n.locale = extract_locale || I18n.default_locale
    end

    def set_current_user
      Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
    end
  
    def protect_pages
      redirect_to new_session_path, alert: t('common.not_logged_in') unless Current.user
    end
end