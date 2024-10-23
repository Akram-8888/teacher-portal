class TeachersController < ApplicationController
before_action :authenticate_teacher!
  def home
   @students = if params[:search].present?
              search_term = "%#{params[:search]}%"
              current_teacher.students.where('LOWER(name) LIKE LOWER(?) OR LOWER(subject) LIKE LOWER(?) OR CAST(marks AS TEXT) LIKE ?', 
              search_term, search_term, search_term)
            else
              current_teacher.students.all
            end
    @students = @students.page(params[:page])            
  end
end
