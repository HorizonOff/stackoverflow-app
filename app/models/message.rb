class Message < ApplicationRecord
  belongs_to :content, counter_cache: true
  belongs_to :user, inverse_of: :messages

  has_many :votes

  validates_presence_of :body

  default_scope -> { order(vote_score: :desc) }
end
