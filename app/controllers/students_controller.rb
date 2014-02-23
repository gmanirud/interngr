class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_student, only: [:edit, :update, :index, :destroy]
  before_action :correct_student, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]


  def index
    @students = Student.paginate(page:params[:page])
    render layout: 'studentLayout'
  end

  def show
    render layout: 'studentLayout'
    @student = Student.find(params[:id])
  end

  def new
      @student = Student.new
      
  end

  def edit
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      sign_in @student #Sign in user once they register
      flash[:success] = "Welcome to Interngration!"
      redirect_to @student
    else
      render 'new'
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    if @student.update_attributes(student_params)
      #handle successful update
      flash[:success] = "Profile Updated"
      redirect_to @student
    else
      render 'edit'
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    Student.find(params[:id]).destroy
    flash[:success] = "Student deleted"
    redirect_to students_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:fname, :lname, :email, :school, :discipline, :year, :password, :password_confirmation)
    end

    def signed_in_student
      unless signed_in?
        store_location
        flash[:notice] = "Please sign in"
        redirect_to student_signin_url
      end      
    end

    def correct_student
      @student = Student.find(params[:id])
      redirect_to(root_url) unless current_student?(@student)
    end

    def admin_user
      redirect_to(root_url) unless current_student.admin?      
    end

end
  