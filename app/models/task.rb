class Task
  include MongoMapper::Document
  include ActionView::Helpers

  many :time_entries

  key :description, String
  key :duration, Integer, :default => 0
  timestamps!
end
