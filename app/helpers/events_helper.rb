module EventsHelper
  def get_events_url_on(profile)

    events = []
    # profile.events.each do |event|
    #   events << {:id => event.id, :title => event.title, :description => event.description || "Some cool description here...", :start => "#{event.starttime.iso8601}", :end => "#{event.endtime.iso8601}", :allDay => event.all_day, :recurring => (event.event_series_id) ? true : false}
    # end
    # events_google = []
    profile_type = profile.class.name.camelize(:lower)+"s"
    events << "/#{profile_type}/#{profile.id}/events/get_events"
    @profile.google_events.each do |event| 
      events << event.url 
    end  
    p events.to_json
    events.to_json.html_safe  
  end

end
