module EventsHelper
  def get_events_url_on(profile)
    events = []
    profile_type = profile.class.name.camelize(:lower)+"s"
    events << "/#{profile_type}/#{profile.id}/events/get_events"
    # IJM Tmp change. due to other events not shown
    # profile.google_events.each do |event|
    #   events << event.url
    # end
    # p '===================================================='
    # p events
    # p '===================================================='
    events.to_json.html_safe
  end

  def get_coaches_events_url
    # ["/events/get_events?profile_type=User"].to_json.html_safe
    events = []
    events << "/events/get_events?profile_type=User"
    # IJM Tmp change. due to other events not shown
    # GoogleEvent.where(profile_type: "User").each do |event|
    #   events << event.url
    # end
    events.to_json.html_safe
  end

end
