class Tag < ApplicationRecord
  has_and_belongs_to_many :contents

  validates :name, presence: true, uniqueness: true
end
