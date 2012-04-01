class SiteSettings < Settingslogic
  source "#{Rails.root}/config/site.yml"
  namespace Rails.env
end