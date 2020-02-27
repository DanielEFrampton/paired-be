class Skill < ApplicationRecord
  validates :name, exclusion: { in: [nil] }

  belongs_to :user
end
