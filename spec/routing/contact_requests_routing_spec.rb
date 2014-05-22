require "spec_helper"

describe ContactRequestsController do
  describe "routing" do

    it "routes to #index" do
      get("/contact_requests").should route_to("contact_requests#index")
    end

    it "routes to #new" do
      get("/contact_requests/new").should route_to("contact_requests#new")
    end

    it "routes to #show" do
      get("/contact_requests/1").should route_to("contact_requests#show", :id => "1")
    end

    it "routes to #edit" do
      get("/contact_requests/1/edit").should route_to("contact_requests#edit", :id => "1")
    end

    it "routes to #create" do
      post("/contact_requests").should route_to("contact_requests#create")
    end

    it "routes to #update" do
      put("/contact_requests/1").should route_to("contact_requests#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/contact_requests/1").should route_to("contact_requests#destroy", :id => "1")
    end

  end
end
