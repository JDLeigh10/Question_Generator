class Answer < ActiveRecord::Base
  attr_accessible :question_id, :right_answer, :wrong_answer1, :wrong_answer2, :wrong_answer3, :interpret
  
  belongs_to :question
  
  def to_choices
    [
      {correct: true,  choice_text: self.right_answer}, 
      {correct: false, choice_text: self.wrong_answer1},
      {correct: false, choice_text: self.wrong_answer2},
      {correct: false, choice_text: self.wrong_answer3}
    ].shuffle
  end
  
end
