# frozen_string_literal: true

30.times do
  title = Faker::App.name
  body = Faker::Lorem.paragraph(sentence_count: 16, supplemental: true, random_sentences_to_add: 4)
  Question.create(title: title, body: body)
end
# 30.times do
#   body = Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4)
#   Question.create(body: body)
# end
5.times do
  # rubocop:todo Lint/UselessAssignment
  body = body = Faker::Lorem.paragraph(sentence_count: 16, supplemental: true, random_sentences_to_add: 4)
  # rubocop:enable Lint/UselessAssignment
  @question = Question.find(params[:id])
  @question.answers.create(body: body)
end
