class Content < ApplicationRecord
  has_many :messages
  has_many :answers, -> { where(answer: true).order(vote_score: :desc) }, class_name: 'Message'
  has_one :question, -> { where(answer: false) }, class_name: 'Message'

  has_and_belongs_to_many :tags

  validates_presence_of :title

  default_scope -> { order(created_at: :desc) }

  def increment_views
    self.update(views_count: self.views_count += 1)
  end
end
