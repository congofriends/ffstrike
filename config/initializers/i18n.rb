# if Rails.env.test? || Rails.env.development?
#   module ActionView::Helpers::TranslationHelper
#     def t_with_raise(*args)
#       value = t_without_raise(*args)

#       if value.to_s.match(/title="translation missing: (.+)"/)
#         raise "Translation missing: #{$1}"
#       else
#         value
#       end
#     end
#     alias_method :translate_with_raise, :t_with_raise

#     alias_method_chain :t, :raise
#     alias_method_chain :translate, :raise
#   end
# end

if ENV['RAILS_ENV'] == 'production'
  I18n::Backend::Simple.send(:include, I18n::Backend::Cache)
  I18n.cache_store = ActiveSupport::Cache.lookup_store(:dalli_store)
end


