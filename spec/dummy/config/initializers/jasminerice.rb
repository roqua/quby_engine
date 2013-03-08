if Rails.env.test? || Rails.env.development?
  Rails.application.config.assets.paths << Quby::Engine.root.join("spec", "javascripts") <<
      Quby::Engine.root.join("spec", "stylesheets")
  # Add engine to view path so that spec/javascripts/fixtures are accessible
  ActionController::Base.prepend_view_path Quby::Engine.root
end
