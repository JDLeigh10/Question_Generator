class QuestionsController < ApplicationController
  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
    
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])
    gen_var_array = []
    @answers = @question.answer.to_choices
    @final_answers_array = []
    
    i = 0
    @question.variables.each_with_index do |v, i|
      gen_var_array << case v.format 
                       when "number" 
                         rand(v.minimum..v.maximum).roundup(v.multiple)
                       when "company" 
                         Company.last(:order => "RANDOM()", :limit => i+1).name
                       end
                       
    @question.question_text.gsub!("~#{i+1}", gen_var_array[i].to_s)
    i += 1                   
    end
    
    @answers.each do |choice|
        10.times do |i|
          choice[:choice_text].gsub!("~#{i+1}", gen_var_array[i].to_s)
        end
      if @question.answer.interpret == 'eval'
        # Note, this is not a secure line of code. The choice[:choice_text] should be sanitized before being eval'd.
        choice[:choice_text] = eval(choice[:choice_text])
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new
    @question.section = params[:section]
    @question.question_text = params[:question_text]
    @question.category = params[:category]
    @question.subclass = params[:subclass]
    @question.number = params[:qnumber]
    @question.save
    
    @answer = Answer.new
    @answer.question_id = @question.id
    @answer.right_answer = params[:right_answer]
    @answer.wrong_answer1 = params[:wrong_answer1]
    @answer.wrong_answer2 = params[:wrong_answer2]
    @answer.wrong_answer3 = params[:wrong_answer3]
    @answer.interpret = params[:interpret]
    @answer.save
    
    variables = []
    
    params.each do |key,value|
      if key.match(/variable/)
        variables << value
      end
    end
    
    variables.each do |hash|
      @variable = Variable.new
      @variable.question_id = @question.id
      @variable.format = hash["format"]
      @variable.number = hash["number"]
      case hash["format"] 
        when "dollars", "number", "percentage"
        @variable.minimum = hash["minimum"]
        @variable.maximum = hash["maximum"]
        @variable.multiple = hash["multiple"]
      end
      @variable.save
    end
            
    respond_to do |format|
      if @question.save
        format.html { redirect_to root_url, notice: 'Question was successfully created.' }
        format.json { render json: root_url, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.json
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end
end
