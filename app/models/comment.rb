class Comment < ApplicationRecord
  validates :body, presence: true
  belongs_to :blog
end
