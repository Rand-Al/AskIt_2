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
  body = body = Faker::Lorem.paragraph(sentence_count: 16, supplemental: true, random_sentences_to_add: 4)
  @question = Question.find(params[:id])
  @question.answers.create( body: body)
end

