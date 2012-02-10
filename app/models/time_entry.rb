class TimeEntry
  include MongoMapper::EmbeddedDocument

  belongs_to :task

  key :startDate, Date
  key :endDate, Date
end
