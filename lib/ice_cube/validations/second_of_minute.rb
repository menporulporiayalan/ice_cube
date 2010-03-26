module SecondOfMinuteValidation
  
  def self.included(base)
    base::SuggestionTypes << :second_of_minute
  end
  
  def second_of_minute(*seconds)
    @seconds_of_minute ||= []
    seconds.each do |second|
      raise ArgumentError.new('Argument must be a valid second') unless second < 60 && second >= 0
      @seconds_of_minute << second
    end
    self
  end
  
  def validate_second_of_minute(date)
    return true if !@seconds_of_minute || @seconds_of_minute.empty?
    @seconds_of_minute.include?(date.sec)
  end
  
  def closest_second_of_minute(date)
    return nil if !@seconds_of_minute || @seconds_of_minute.empty?
    # turn seconds into seconds of minute
    # second >= 60 should fall into the next minute
    seconds = @seconds_of_minute.map do |s|
      s > date.sec ? s - date.sec : 60 - date.sec + s
    end
    seconds.compact!
    # go to the closest distance away
    closest_second = seconds.min
    date + closest_second
  end
  
end