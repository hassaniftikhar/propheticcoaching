module EventsHelper
  def get_events_url_on(profile)
    events = []
    profile_type = profile.class.name.camelize(:lower)+"s"
    events << "/#{profile_type}/#{profile.id}/events/get_events"
    profile.google_events.each do |event|
      events << event.url
    end
    p events
    events.to_json.html_safe
  end

  def get_coaches_events_url
    ["/events/get_events?profile_type=User"].to_json.html_safe
  end

end
