SiteSettings.paperclip_options.each do |key, value|
  Paperclip::Attachment.default_options[key.to_sym] = value
end