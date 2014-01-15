require "spec_helper"

describe MenteesController do
  describe "routing" do

    it "routes to #index" do
      get("/mentees").should route_to("mentees#index")
    end

    it "routes to #new" do
      get("/mentees/new").should route_to("mentees#new")
    end

    it "routes to #show" do
      get("/mentees/1").should route_to("mentees#show", :id => "1")
    end

    it "routes to #edit" do
      get("/mentees/1/edit").should route_to("mentees#edit", :id => "1")
    end

    it "routes to #create" do
      post("/mentees").should route_to("mentees#create")
    end

    it "routes to #update" do
      put("/mentees/1").should route_to("mentees#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/mentees/1").should route_to("mentees#destroy", :id => "1")
    end

  end
end
