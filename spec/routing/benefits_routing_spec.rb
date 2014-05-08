require "spec_helper"

describe BenefitsController do
  describe "routing" do

    it "routes to #index" do
      get("/benefits").should route_to("benefits#index")
    end

    it "routes to #new" do
      get("/benefits/new").should route_to("benefits#new")
    end

    it "routes to #show" do
      get("/benefits/1").should route_to("benefits#show", :id => "1")
    end

    it "routes to #edit" do
      get("/benefits/1/edit").should route_to("benefits#edit", :id => "1")
    end

    it "routes to #create" do
      post("/benefits").should route_to("benefits#create")
    end

    it "routes to #update" do
      put("/benefits/1").should route_to("benefits#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/benefits/1").should route_to("benefits#destroy", :id => "1")
    end

  end
end
