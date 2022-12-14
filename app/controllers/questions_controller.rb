# frozen_string_literal: true

class QuestionsController < ApplicationController # rubocop:todo Style/Documentation
  before_action :set_question, only: %i[show edit update destroy]

  def index
    @questions = Question.order(created_at: :desc).page(params[:page]).per(5)
  end

  def new
    @question = Question.new
  end

  def edit; end

  def update
    if @question.update(question_params)
      flash[:success] = 'Your question was edit!' # rubocop:todo Rails/I18nLocaleTexts
      redirect_to questions_path
    else
      render :edit
    end
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = 'Your question was asked!' # rubocop:todo Rails/I18nLocaleTexts
      redirect_to questions_path
    else
      render :new
    end
  end

  def show
    @answer = Answer.new
    @answers = @question.answers.all.order(created_at: :desc)
  end

  def destroy
    flash[:success] = 'Your question was deleted!' # rubocop:todo Rails/I18nLocaleTexts
    @question.destroy
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
