module ApplicationHelper

  def show_alerts
    message = '<div class="col-md-12">'
    if !flash[:error].blank?
      message += content_tag :div, flash[:error], :class => "alert alert-danger"
    end
    if !flash[:notice].blank?
      message += content_tag :div, flash[:notice], :class => "alert alert-success"
    end
    message += '</div>'
    message.html_safe
  end
end
