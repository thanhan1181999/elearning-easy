class CoursesController < ApplicationController
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
            redirect_to root_url
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
        Course.find(params[:course_id]).destroy
        flash[:success] = "Course deleted"
        redirect_to user_pathP current_user
    end

    private
        def course_params 
            params.require(:course).permit(:content, :picture, :course_category_id, :name)
        end
end
