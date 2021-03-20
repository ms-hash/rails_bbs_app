class Blog < ApplicationRecord
  belongs_to :category
  is_impressionable counter_cache: true
end
