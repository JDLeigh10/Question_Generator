class Question < ActiveRecord::Base
  attr_accessible :category, :number, :question_text, :section, :subclass
  
  has_many :variables
  has_one :answer
end
