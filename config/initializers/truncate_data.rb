# Truncate data models, especially during development.

if Ffstrike::Application.config.truncate_models
  Ffstrike::Application.config.truncate_models.each do |model|
    model.to_s.camelcase.constantize.delete_all
  end
end
