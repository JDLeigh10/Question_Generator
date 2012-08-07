# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
QuestionForm::Application.initialize!

class Numeric
  def roundup(nearest)
    self % nearest == 0 ? self : self + nearest - (self % nearest)
  end
end

class String
  def add_commas(string)
    return string.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end
end