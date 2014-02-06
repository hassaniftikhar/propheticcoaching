require 'spec_helper'


describe GoogleEventsController do

  # This should return the minimal set of attributes required to create a valid
  # Goal. As you add validations to Goal, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {"body" => "MyString"} }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # GoalsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  include Devise::TestHelpers
  before (:each) do
    @user = FactoryGirl.create :user
    @mentee = FactoryGirl.create :mentee
    @mentee.coach_id = @user.id
    @mentee.save!
    sign_in @user
  end


  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  #describe "GET 'update'" do
  #  it "returns http success" do
  #    get 'update'
  #    response.should be_success
  #  end
  #end
  #
  #describe "GET 'edit'" do
  #  it "returns http success" do
  #    get 'edit'
  #    response.should be_success
  #  end
  #end
  #
  #describe "GET 'destroy'" do
  #  it "returns http success" do
  #    get 'destroy'
  #    response.should be_success
  #  end
  #end
  #
  #describe "GET 'index'" do
  #  it "returns http success" do
  #    get 'index'
  #    response.should be_success
  #  end
  #end
  #
  #describe "GET 'show'" do
  #  it "returns http success" do
  #    get 'show'
  #    response.should be_success
  #  end
  #end

end
