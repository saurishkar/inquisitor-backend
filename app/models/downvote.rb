class Downvote < ApplicationRecord
  belongs_to :source, polymorphic: true
end
