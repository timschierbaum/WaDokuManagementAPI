require 'spec_helper'

describe UsersController do
  @@admin ||= FactoryGirl.create(:admin)
  @@user ||= FactoryGirl.create(:user)
  @@editor ||= FactoryGirl.create(:editor)


  describe "test if only admins can inspect the user list" do
    it "should show user list to admin" do
      sign_in @@admin
      get :index
      response.status.should be 200
      sign_out @@admin
    end
    it "should not show user list to user or editor" do
      sign_in @@editor
      get :index
      response.status.should be 302
      sign_out @@editor
      sign_in @@user
      get :index
      response.status.should be 302
      sign_out @@user
    end
  end

  describe "test if only admins can read users' information and update their status" do
    it "should show user's information to admin" do
      sign_in @@admin
      get :index, :id => 1
      response.status.should be 200
      sign_out @@admin
    end
    before :each do
      @new_user = FactoryGirl.create(:user)
    end

    it "should locate the requested user and update status for admin" do
      sign_in @@admin
      put :update, :id => @new_user.id, user: FactoryGirl.attributes_for(:user, status: "editor")
      assigns(:user).should eq(@new_user)
      @new_user.reload
      @new_user.status.should == "editor"
      sign_out @@admin
    end

    it "should not show user's information to user or editor" do
      sign_in @@user
      put :update, :id => @new_user.id, user: FactoryGirl.attributes_for(:user, status: "editor")
      @new_user.reload
      @new_user.status.should_not == "editor"
      sign_out @@user
    end

    it "should update other attributes of current user's profile but no status" do
      sign_in @new_user
      put :update, :id => @new_user.id, :user => {"name" => "new_name", "email" => "new@email.com", "status" => "alien"}
      @new_user.reload
      @new_user.status.should_not == "alien"
      @new_user.status.should == "user"
      @new_user.name.should == "new_name"
      @new_user.email.should == "new@email.com"
      sign_out @new_user
    end

  end

  describe "test if current user can edit his own profile" do
    it "should show edit page for current user's own profile" do
      sign_in @@user
      get :edit, :id => @@user.id
      response.should render_template("edit")
      sign_out @@user
    end
    it "should not show edit page for another user's profile" do
      sign_in @@user
      get :edit, :id => @@editor.id 
      response.should_not render_template("edit")
      response.should redirect_to root_path
      sign_out @@user
    end
  end

  describe "test if can delete a user" do
    before :each do
      @new_user = FactoryGirl.create(:user)
    end
    it "should delete a user" do
      sign_in @@user
      expect{
        delete :destroy, :id => @new_user.id
      }.to change(User, :count).by(-1)
      response.should redirect_to users_path
      sign_out @@user
    end
  end


end
