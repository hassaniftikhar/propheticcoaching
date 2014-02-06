require 'spec_helper'

describe EventsController do

  let(:valid_attributes) { {title: "test event", description: "event description", starttime: Time.now,
                            endtime: (Time.now + 1.hour) } }

  let(:valid_session) { { } }

  describe "GET index" do
    #it "" do
    #end
  end

end
