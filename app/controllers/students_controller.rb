class StudentsController < ApplicationController
	before_action :authenticate_teacher!

	def new
		@student = Student.new
	end

  	def create
    existing_student = current_teacher.students
                       .where("LOWER(name) = ? AND LOWER(subject) = ?", 
                              student_params[:name].downcase, 
                              student_params[:subject].downcase)
                       .first

    if existing_student
      existing_student.marks = student_params[:marks].to_i
      if existing_student.save
        render json: { message: "Student already existing just Marks updated for #{existing_student.name}." }, status: :ok
      else
        render json: { errors: existing_student.errors.full_messages }, status: :unprocessable_entity
      end
    else
      # Create a new student record if none exists
      @student = current_teacher.students.build(student_params)
      if @student.save
        render json: { message: "Student created successfully." }, status: :created
      else
        render json: { errors: @student.errors.full_messages }, status: :unprocessable_entity
      end
    end
end

  def index
    @students = current_teacher.students # Fetch only the current teacher's students
  end

  def edit
  	@student = Student.find(params[:id])
  end

  def update
  	@student = Student.find(params[:id])

  	if @student.update(student_params)
  		redirect_to root_path, notice: 'Student updated successfully.'
  	else
  		render :edit
  	end
  end

  def destroy
  	student = Student.find(params[:id])
  	student.destroy
  	redirect_to root_path, notice: 'Student deleted successfully.'
  end

  private

  def student_params
  	params.require(:student).permit(:name, :subject, :marks)
  end
end
