module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?
    sentence = I18n.t("errors.messages.not_found")
    html = <<-HTML
    <div id="error_explanation">
      <h3>#{sentence}</h3>
    </div>
    HTML
    html.html_safe
  end
end
