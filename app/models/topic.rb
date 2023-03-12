class Topic < ApplicationRecord
  validates :author_id, presence: true
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  has_many :suggestions

  after_create_commit { broadcast_prepend_to "topics"}
  after_update_commit { broadcast_replace_to "topics"}
  after_destroy_commit { broadcast_remove_to "topics"}
end