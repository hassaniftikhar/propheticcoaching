require "spec_helper"

describe GoalsController do
  describe "routing" do

    it "routes to #index" do
      get("/users/8/mentees/250/goals").should route_to("goals#index")
    end

    it "routes to #new" do
      get("/users/8/mentees/250/goals/new").should route_to("goals#new")
    end

    it "routes to #show" do
      get("/users/8/mentees/250/goals/1").should route_to("goals#show", :id => "1")
    end

    it "routes to #edit" do
      get("/goals/1/edit").should route_to("goals#edit", :id => "1")
    end

    it "routes to #create" do
      post("/users/8/mentees/250/goals").should route_to("goals#create")
    end

    it "routes to #update" do
      put("/users/8/mentees/250/goals/1").should route_to("goals#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/users/8/mentees/250/goals/1").should route_to("goals#destroy", :id => "1")
    end

  end
end
