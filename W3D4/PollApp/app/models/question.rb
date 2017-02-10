class Question < ActiveRecord::Base

  validates :text, :poll_id, presence: true

  has_many :answer_choices,
    class_name: :AnswerChoice,
    primary_key: :id,
    foreign_key: :question_id

  belongs_to :poll,
    class_name: :Poll,
    primary_key: :id,
    foreign_key: :poll_id

  has_many :responses,
    through: :answer_choices,
    source: :responses

    def results
      count = Hash.new(0)
      answer_choices.pluck(:text).each do |answer|
        choices = answer.split(" * ")
        choices.each do |choice|
          count[choice] += 1
        end
      end
      count
    end

end
