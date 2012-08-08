class Answer < ActiveRecord::Base
  attr_accessible :question_id, :right_answer, :wrong_answer1, :wrong_answer2, :wrong_answer3, :interpret
  
  belongs_to :Question
end
