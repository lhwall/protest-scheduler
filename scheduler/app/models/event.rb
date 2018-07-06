class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  def formatted_time
    self.time.to_s.split[1]
  end

end
