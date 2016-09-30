ActiveAdmin.register Question do

permit_params :content, :level_id, answers_attributes: [:id, :content, :question_id, :_destroy, :is_correct]

  form  do |f|
    f.inputs 'Question' do
      f.input :content
      f.input :is_active
      f.input :level
    end
    f.inputs 'Answer' do
      f.has_many :answers, allow_destroy: true do |a|
        a.input :content
        a.input :is_correct
      end
    f.actions
    end
  end
end