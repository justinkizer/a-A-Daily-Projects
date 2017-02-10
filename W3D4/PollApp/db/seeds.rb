# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(user_name: "Jean-Luc")
User.create!(user_name: "Data")
User.create!(user_name: "Warf")
Poll.create!(title: "Test Poll", author_id: 1)
Question.create!(text: "Prime Directive?", poll_id: 1)
Question.create!(text: "Dilythium crystals?", poll_id: 1)
AnswerChoice.create!(text: "Non-intervention in pre-warp civilizations.",
question_id: 1)
AnswerChoice.create!(text: "Used with flux capcitors...?",
question_id: 2)
AnswerChoice.create!(text: "Inside warp core; Wes can hack them!", question_id: 2)
Response.create!(questioner_id: 1, respondent_id: 2, answer_id: 1)
Response.create!(questioner_id: 1, respondent_id: 3, answer_id: 2)
Response.create!(questioner_id: 2, respondent_id: 1, answer_id: 3)
