require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe AccomplishmentsController do

  # This should return the minimal set of attributes required to create a valid
  # Accomplishment. As you add validations to Accomplishment, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "body" => "MyText" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AccomplishmentsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all accomplishments as @accomplishments" do
      accomplishment = Accomplishment.create! valid_attributes
      get :index, {}, valid_session
      assigns(:accomplishments).should eq([accomplishment])
    end
  end

  describe "GET show" do
    it "assigns the requested accomplishment as @accomplishment" do
      accomplishment = Accomplishment.create! valid_attributes
      get :show, {:id => accomplishment.to_param}, valid_session
      assigns(:accomplishment).should eq(accomplishment)
    end
  end

  describe "GET new" do
    it "assigns a new accomplishment as @accomplishment" do
      get :new, {}, valid_session
      assigns(:accomplishment).should be_a_new(Accomplishment)
    end
  end

  describe "GET edit" do
    it "assigns the requested accomplishment as @accomplishment" do
      accomplishment = Accomplishment.create! valid_attributes
      get :edit, {:id => accomplishment.to_param}, valid_session
      assigns(:accomplishment).should eq(accomplishment)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Accomplishment" do
        expect {
          post :create, {:accomplishment => valid_attributes}, valid_session
        }.to change(Accomplishment, :count).by(1)
      end

      it "assigns a newly created accomplishment as @accomplishment" do
        post :create, {:accomplishment => valid_attributes}, valid_session
        assigns(:accomplishment).should be_a(Accomplishment)
        assigns(:accomplishment).should be_persisted
      end

      it "redirects to the created accomplishment" do
        post :create, {:accomplishment => valid_attributes}, valid_session
        response.should redirect_to(Accomplishment.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved accomplishment as @accomplishment" do
        # Trigger the behavior that occurs when invalid params are submitted
        Accomplishment.any_instance.stub(:save).and_return(false)
        post :create, {:accomplishment => { "body" => "invalid value" }}, valid_session
        assigns(:accomplishment).should be_a_new(Accomplishment)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Accomplishment.any_instance.stub(:save).and_return(false)
        post :create, {:accomplishment => { "body" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested accomplishment" do
        accomplishment = Accomplishment.create! valid_attributes
        # Assuming there are no other accomplishments in the database, this
        # specifies that the Accomplishment created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Accomplishment.any_instance.should_receive(:update).with({ "body" => "MyText" })
        put :update, {:id => accomplishment.to_param, :accomplishment => { "body" => "MyText" }}, valid_session
      end

      it "assigns the requested accomplishment as @accomplishment" do
        accomplishment = Accomplishment.create! valid_attributes
        put :update, {:id => accomplishment.to_param, :accomplishment => valid_attributes}, valid_session
        assigns(:accomplishment).should eq(accomplishment)
      end

      it "redirects to the accomplishment" do
        accomplishment = Accomplishment.create! valid_attributes
        put :update, {:id => accomplishment.to_param, :accomplishment => valid_attributes}, valid_session
        response.should redirect_to(accomplishment)
      end
    end

    describe "with invalid params" do
      it "assigns the accomplishment as @accomplishment" do
        accomplishment = Accomplishment.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Accomplishment.any_instance.stub(:save).and_return(false)
        put :update, {:id => accomplishment.to_param, :accomplishment => { "body" => "invalid value" }}, valid_session
        assigns(:accomplishment).should eq(accomplishment)
      end

      it "re-renders the 'edit' template" do
        accomplishment = Accomplishment.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Accomplishment.any_instance.stub(:save).and_return(false)
        put :update, {:id => accomplishment.to_param, :accomplishment => { "body" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested accomplishment" do
      accomplishment = Accomplishment.create! valid_attributes
      expect {
        delete :destroy, {:id => accomplishment.to_param}, valid_session
      }.to change(Accomplishment, :count).by(-1)
    end

    it "redirects to the accomplishments list" do
      accomplishment = Accomplishment.create! valid_attributes
      delete :destroy, {:id => accomplishment.to_param}, valid_session
      response.should redirect_to(accomplishments_url)
    end
  end

end