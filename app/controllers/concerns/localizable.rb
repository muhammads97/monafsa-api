module Localizable
  extend ActiveSupport::Concern

  included do
    around_action :switch_locale
  end

  def switch_locale(&action)        
    I18n.locale = valid_locale
    I18n.with_locale(valid_locale, &action)
  end

  def valid_locale
    locale = header_locale || params[:locale] || I18n.default_locale
    I18n.available_locales.include?(locale.try(:to_sym)) ? locale : I18n.default_locale
  end

  private
  def header_locale
    return extract_locale_from_accept_language_header if request.env['HTTP_ACCEPT_LANGUAGE']
    nil
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end