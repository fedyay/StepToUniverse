class HomeworksController < ApplicationController
  
  def create
    params[:homework][:text_files_attributes].each do |at|
      @a = params[:homework][:text_files_attributes][at.to_sym][:file]
      @a = @a.original_filename
      params[:homework][:text_files_attributes][at.to_sym][:pather] = @a
    end

    @homework = Homework.new(homework_params)

    if @homework.save

      redirect_to cabinet_path, notice: 'Домашнее задание успешно создано.'
    else
      render 'cabinet'
    end
  end

  def assign
    if HomeworkAssignment.create(assignment_params)
      redirect_to cabinet_path, notice: 'Домашнее задание успешно отправлено.'
    else
      render 'cabinet'
    end
  end

  def result
    if @assign = HomeworkResult.create(result_params)
      @assign = @assign.homework_assignment
      @assign.is_done = true
      @assign.save
      redirect_to cabinet_path, notice: 'Домашнее задание успешно завершено.'
    else
      render 'cabinet'
    end
  end

  def check
    @result = HomeworkResult.find(params[:id])
    if @result.update(result_params)
      redirect_to cabinet_path, notice: 'Домашнее задание успешно проверенно.'
    else
      render 'cabinet'
    end
  end

  private

  def homework_params
    params.require(:homework).permit(:title, :user_id, text_files_attributes: [:id, :name, :description, :file, :pather, :homework_id])
  end

  def assignment_params
    params.require(:homework_assignment).permit(:user_id, :homework_id)
  end

  def result_params
    params.require(:homework_result).permit(:is_checked, :homework_assignment_id)
  end

end