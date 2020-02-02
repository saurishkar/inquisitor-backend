# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  before_save :answered_by_user?

  def answered_by_user?
    is_answered = Question.find(self[:question_id])
                          .answers
                          .where(user_id: self[:user_id]).count.positive?
    errors.add(:base, message: 'Question is already answered by user')
    throw(:abort) if is_answered
  end
end
