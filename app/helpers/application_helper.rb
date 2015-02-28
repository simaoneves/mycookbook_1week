module ApplicationHelper

  def show_alerts

    if !flash[:error].blank? || !flash[:notice].blank?
      
      message = '<div class="col-md-12">'
      
      if !flash[:error].blank?
        message += "<div class='alert alert-danger alert-dismissible'>"
        message += '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'
        message += flash[:error].html_safe
      end
      if !flash[:notice].blank?
        message += "<div class='alert alert-success alert-dismissible'>"
        message += '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'
        message += flash[:notice].html_safe
      end
      
      message += '</div>'
      message += '</div>'
      message.html_safe

    end

  end

  def current_user_profile?
    @user.id == session[:user_id]
  end

  def current_user_recipe?
    @recipe.user.id == session[:user_id]
  end
  
end
