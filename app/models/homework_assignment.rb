class HomeworkAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :homework
  has_one :homework_result
end
