class TimeEntry
  include MongoMapper::EmbeddedDocument

  belongs_to :task

  key :startDate, Time
  key :endDate, Time
end
