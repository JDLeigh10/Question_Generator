class Variable < ActiveRecord::Base
  attr_accessible :format, :maximum, :minimum, :multiple, :question_id, :name, :number
  
  belongs_to :Question
end
