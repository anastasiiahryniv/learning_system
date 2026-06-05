module ApplicationHelper
  def locale_to_flag(locale)
    locales = {
      'en' => '🇬🇧',
      'es' => '🇪🇸'
    }
    locales[locale.to_s]
  end
end
