class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.string :right_answer
      t.string :wrong_answer1
      t.string :wrong_answer2
      t.string :wrong_answer3

      t.timestamps
    end
  end
end
