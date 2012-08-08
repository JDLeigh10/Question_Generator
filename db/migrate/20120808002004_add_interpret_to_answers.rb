class AddInterpretToAnswers < ActiveRecord::Migration
  def change
    
    add_column :answers, :interpret, :string
    
  end
end
