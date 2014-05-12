require "spec_helper"

describe BestFeaturesController do
  describe "routing" do

    it "routes to #index" do
      get("/best_features").should route_to("best_features#index")
    end

    it "routes to #new" do
      get("/best_features/new").should route_to("best_features#new")
    end

    it "routes to #show" do
      get("/best_features/1").should route_to("best_features#show", :id => "1")
    end

    it "routes to #edit" do
      get("/best_features/1/edit").should route_to("best_features#edit", :id => "1")
    end

    it "routes to #create" do
      post("/best_features").should route_to("best_features#create")
    end

    it "routes to #update" do
      put("/best_features/1").should route_to("best_features#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/best_features/1").should route_to("best_features#destroy", :id => "1")
    end

  end
end
