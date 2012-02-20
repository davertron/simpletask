class Task
  include MongoMapper::Document
  include ActionView::Helpers

  many :time_entries
  belongs_to :user

  key :description, String
  key :archived, Boolean, :default => false
  timestamps!
end
