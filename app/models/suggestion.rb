class Suggestion < ApplicationRecord
  validates :author_id, presence: true
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  belongs_to :topic

  after_create_commit { broadcast_prepend_to "suggestions"}
  after_update_commit { broadcast_replace_to "suggestions"}
  after_destroy_commit { broadcast_remove_to "suggestions"}
end
