require "spec_helper"

describe AccomplishmentsController do
  describe "routing" do

    it "routes to #index" do
      get("/accomplishments").should route_to("accomplishments#index")
    end

    it "routes to #new" do
      get("/accomplishments/new").should route_to("accomplishments#new")
    end

    it "routes to #show" do
      get("/accomplishments/1").should route_to("accomplishments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/accomplishments/1/edit").should route_to("accomplishments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/accomplishments").should route_to("accomplishments#create")
    end

    it "routes to #update" do
      put("/accomplishments/1").should route_to("accomplishments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/accomplishments/1").should route_to("accomplishments#destroy", :id => "1")
    end

  end
end
