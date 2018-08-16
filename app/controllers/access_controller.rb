class AccessController < ApplicationController
  def menu
  end

  def login
  end

  def attempt_login
    if params[:uname].present? && params[:upwd].present?
      found_user = AdminUser.where(:username => params[:uname]).first
      if found_user
        authorized_user = found_user.authenticate(params[:upwd])
      end
    end

    if authorized_user
      session[:user_id] = authorized_user.id
      puts "Login successfully"
      flash[:notice] = "Welcome #{authorized_user.last_name}, #{authorized_user.first_name}!"
      redirect_to(workflow_templates_path)
    else
      puts "incorrect username/password."
      flash[:notice] = "Incorrect username/password."
      render('login')
    end
  end

  def logout
    session[:user_id] = nil
    puts "logged out successfully."
    flash[:notice] = "Logged out!"
    redirect_to(admin_path)
  end
end
