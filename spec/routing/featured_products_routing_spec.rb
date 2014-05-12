require "spec_helper"

describe FeaturedProductsController do
  describe "routing" do

    it "routes to #index" do
      get("/featured_products").should route_to("featured_products#index")
    end

    it "routes to #new" do
      get("/featured_products/new").should route_to("featured_products#new")
    end

    it "routes to #show" do
      get("/featured_products/1").should route_to("featured_products#show", :id => "1")
    end

    it "routes to #edit" do
      get("/featured_products/1/edit").should route_to("featured_products#edit", :id => "1")
    end

    it "routes to #create" do
      post("/featured_products").should route_to("featured_products#create")
    end

    it "routes to #update" do
      put("/featured_products/1").should route_to("featured_products#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/featured_products/1").should route_to("featured_products#destroy", :id => "1")
    end

  end
end
