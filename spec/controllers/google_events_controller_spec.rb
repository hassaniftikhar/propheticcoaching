require 'spec_helper'


describe GoogleEventsController do

  # This should return the minimal set of attributes required to create a valid
  # Goal. As you add validations to Goal, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {"url" => "http://www.google.com"} }

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


  describe "GET new" do
    it 'creates a resource' do
      get :new, {mentee_id: @mentee.id}, valid_session
      response.header['Content-Type'].should include 'application/json'
    end

    it "assigns a google_event event as @google_event" do
      get :new, {mentee_id: @mentee.id}, valid_session
      assigns(:google_event).should be_a_new(GoogleEvent)
    end
  end

  describe "POST create" do

    before (:each) do
      controller.request.stub referer: 'http://localhost:3000'
    end

    describe "with valid params" do
      it "creates a new Google Event" do
        expect {
          post :create, {user_id: @user.id, google_event: valid_attributes}, valid_session
        }.to change(GoogleEvent, :count).by(1)
      end

      it "assigns a newly created google event as @google_event" do
        post :create, {user_id: @user.id, google_event: valid_attributes}, valid_session
        assigns(:google_event).should be_a(GoogleEvent)
        assigns(:google_event).should be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved google event as @google_event" do
        # Trigger the behavior that occurs when invalid params are submitted
        GoogleEvent.any_instance.stub(:save).and_return(false)
        post :create, {:google_event => {"url" => "invalid/value"}}, valid_session
        assigns(:google_event).should be_a_new(GoogleEvent)
      end

    #  it "re-renders the 'new' template" do
    #    # Trigger the behavior that occurs when invalid params are submitted
    #    Ebook.any_instance.stub(:save).and_return(false)
    #    post :create, {:ebook => {"name" => "invalid value"}}, valid_session
    #    response.should render_template("new")
    #  end
    end
  end

  #describe "GET 'new'" do
  #  it "returns http success" do
  #    get 'new'
  #    response.should be_success
  #  end
  #end

  #describe "GET 'create'" do
  #  it "returns http success" do
  #    get 'create'
  #    response.should be_success
  #  end
  #end

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
