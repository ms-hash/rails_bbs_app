class Blog < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  belongs_to :category
  is_impressionable counter_cache: true
end
