class Response < ActiveRecord::Base
  validates :questioner_id, :respondent_id, :answer_id, presence: true
  validate :response_already_answered?, :self_dealing?

  belongs_to :respondent,
    class_name: :User,
    primary_key: :id,
    foreign_key: :respondent_id

  belongs_to :answer_choice,
    class_name: :AnswerChoice,
    primary_key: :id,
    foreign_key: :answer_id

  has_one :question,
    through: :answer_choice,
    source: :question

  def self_dealing?
    if answer_choice.question.poll.author_id == respondent_id
      errors[:cannot] << "answer own poll"
    end
  end

  def response_already_answered?
    if not_duplicate_response.any?{ |r| r.respondent_id == self.respondent_id }
      errors[:reponse] << "already answered"
    end
  end

  def not_duplicate_response
    uniq_responses = []
    sibling_responses.each do |resp|
      uniq_responses << resp if uniq_responses.none?{ |r| r.respondent_id == resp.respondent_id }
    end
    uniq_responses
  end

  def sibling_responses
    question
      .responses
  end

end
