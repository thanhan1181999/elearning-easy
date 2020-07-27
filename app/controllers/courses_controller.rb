class CoursesController < ApplicationController

    def index
        # lay ra cac course co so tu > 0
        @courses_ids = Course.joins(lessons: [:words]).group("courses.id").pluck("courses.id")
        @courses = Course.where(id: @courses_ids).paginate(page: params[:page],per_page: 10)
    end
    #get form to create course
    def new
        @course = current_user.courses.build
        @courseCategory = CourseCategory.all
    end

    #post create course
    def create
        @course = current_user.courses.build(course_params)
        @courseCategory = CourseCategory.all
        if @course.save
            flash[:success] = "course created!"
            redirect_to user_path(current_user)
        else
            render 'new' 
        end
    end

    #get to show all lesson in course
    def show
        @course = Course.find(params[:id])
        @lessons = @course.lessons 
    end

    def destroy
        if isAdmin? || Course.find(params[:course_id]).user == current_user
            Course.find(params[:course_id]).destroy
            flash[:success] = "Course deleted"    
        else
            flash[:warm] = "only admin or owner can delete course"
        end  
        redirect_to user_path current_user
    end

    private
        def course_params 
            params.require(:course).permit(:content, :picture, :course_category_id, :name)
        end
end
