class AddUserToProfileAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :profile_answers, :user, :referensec
  end
end
