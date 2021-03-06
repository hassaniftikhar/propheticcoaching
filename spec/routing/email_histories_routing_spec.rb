require "spec_helper"

describe EmailHistoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/email_histories").should route_to("email_histories#index")
    end

    it "routes to #new" do
      get("/email_histories/new").should route_to("email_histories#new")
    end

    it "routes to #show" do
      get("/email_histories/1").should route_to("email_histories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/email_histories/1/edit").should route_to("email_histories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/email_histories").should route_to("email_histories#create")
    end

    it "routes to #update" do
      put("/email_histories/1").should route_to("email_histories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/email_histories/1").should route_to("email_histories#destroy", :id => "1")
    end

  end
end
