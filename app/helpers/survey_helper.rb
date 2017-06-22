module SurveyHelper

  def survey_error_messages!
    return "" if @survey.errors.empty?

    messages = @survey.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      count: @survey.errors.count,
                      resource: @survey.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
      <h2>#{sentence}</h2>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end


end
