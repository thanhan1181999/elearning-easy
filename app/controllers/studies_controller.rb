class StudiesController < ApplicationController
  # skip_before_action :verify_authenticity_token only: [:create, :destroy]
  def create 
    @study = Study.find_by user_id: params[:study][:user_id],word_id: params[:study][:word_id] 
    @study ||= Study.new(study_params)
    @study.save  
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @study = Study.find_by user_id: params[:study][:user_id],word_id: params[:study][:word_id] 
    @study.destroy unless @study.blank?
    respond_to do |format|
      format.js
    end
  end

  def study_params
    params.require(:study).permit(:user_id, :word_id)
  end
  
end
