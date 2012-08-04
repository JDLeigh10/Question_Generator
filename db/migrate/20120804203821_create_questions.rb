class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :section
      t.text :question_text
      t.string :category
      t.string :subclass
      t.integer :number

      t.timestamps
    end
  end
end
