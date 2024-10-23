class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(resource)
    root_path  # Change this to the path you want to redirect after sign in
  end

  def after_sign_out_path_for(resource_or_scope)
    new_teacher_session_path  # Redirects to the sign-in page
  end
end
