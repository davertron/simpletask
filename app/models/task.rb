class Task
  include MongoMapper::Document
  include ActionView::Helpers

  many :time_entries

  key :description, String
  key :archived, Boolean, :default => false
  timestamps!
end
