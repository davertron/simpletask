class Task
  include MongoMapper::Document
  include ActionView::Helpers

  many :time_entries

  key :description, String
  timestamps!
end
