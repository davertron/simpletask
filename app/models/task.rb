class Task
  include MongoMapper::Document

  key :description, String
  key :duration, Integer, :default => 0
  timestamps!

  # Duration is stored in seconds, so this is a nicer representation of the duration
  def formatted_duration
    hours = @duration / 3600
    minutes = (@duration - (hours * 3600)) / 60
    seconds = @duration - (hours * 3600) - (minutes * 60)

    return "#{hours}:#{minutes}:#{seconds}"
  end
end
