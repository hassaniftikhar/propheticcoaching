class Event < ActiveRecord::Base
  attr_accessor :period, :frequency, :commit_button

  validate :update_profile
  validates_presence_of :title, :description
  validate :validate_timings
  
  belongs_to :profile, :polymorphic => true
  belongs_to :event_series
  belongs_to :coach_mentee_relation
  has_many :time_slots

  scope :GenericEvents, -> { where('coach_mentee_relation_id IS NULL') }
  # scope :GenericEvents, where('coach_mentee_relation_id IS NULL')
  # scope :Meetings, where('coach_mentee_relation_id IS NOT NULL') 
  scope :Meetings, -> { where('coach_mentee_relation_id IS NOT NULL') }

  delegate :coach_id, to: :coach_mentee_relation, :allow_nil => true
  delegate :mentee_id, to: :coach_mentee_relation, :allow_nil => true

  REPEATS = [
              "Does not repeat",
              "Daily"          ,
              "Weekly"         ,
              "Monthly"        ,
              "Yearly"         
  ]
  def update_profile
    unless self.profile
      if self.coach_mentee_relation_id
        self.profile_id = CoachMenteeRelation.find_by(:id => self.coach_mentee_relation_id).coach_id
        self.profile_type = "User"
      end
    end
  end

  def remaining_time
    (self.endtime - self.starttime) - self.time_slots.sum(:time_seconds)
  end
  
  
  def validate_timings
    if (starttime >= endtime) and !all_day
      errors[:base] << "Start Time must be less than End Time"
    end
  end
  
  def update_events(events, event)
    events.each do |e|
      begin 
        st, et = e.starttime, e.endtime
        e.attributes = event
        if event_series.period.downcase == 'monthly' or event_series.period.downcase == 'yearly'
          nst = DateTime.parse("#{e.starttime.hour}:#{e.starttime.min}:#{e.starttime.sec}, #{e.starttime.day}-#{st.month}-#{st.year}")  
          net = DateTime.parse("#{e.endtime.hour}:#{e.endtime.min}:#{e.endtime.sec}, #{e.endtime.day}-#{et.month}-#{et.year}")
        else
          nst = DateTime.parse("#{e.starttime.hour}:#{e.starttime.min}:#{e.starttime.sec}, #{st.day}-#{st.month}-#{st.year}")  
          net = DateTime.parse("#{e.endtime.hour}:#{e.endtime.min}:#{e.endtime.sec}, #{et.day}-#{et.month}-#{et.year}")
        end
        #puts "#{nst}           :::::::::          #{net}"
      rescue
        nst = net = nil
      end
      if nst and net
        #          e.attributes = event
        e.starttime, e.endtime = nst, net
        e.save
      end
    end
    
    event_series.attributes = event
    event_series.save
  end
  
  
  
end
