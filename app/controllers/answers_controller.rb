class AnswersController < ApplicationController
  before_action :find_question

  def index
    @answer = @question.answers.find(params[:id])
    render 'questions/show'
  end


  def create
    flash[:success] = 'Your answer was asked!'
    @answer = @question.answers.build(answer_params)
    if @answer.save
      redirect_to question_path(@question, anchor: "answer-#{ @answer.id }")
    else
      @question.reload      
      @answers = @question.answers
      render 'questions/show'
    end
  end

  def edit
    @answer = @question.answers.find(params[:id])
  end

  def update 
    flash[:success] = 'Your answer was edit!'
    @answer = @question.answers.find(params[:id])
    if @answer.update(answer_params)
      redirect_to question_path(@question, anchor: "answer-#{ @answer.id }")
    else
      render :edit
    end
  end

  def destroy
    flash[:success] = 'Your Answer was Deleted!'
    @answer = @question.answers.find(params[:id])
    @answer.destroy
    redirect_to question_path(@question)
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end
end