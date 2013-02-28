require 'spec_helper'

describe UsersController do
  describe "test if only admins can inspect the user list" do
    it "should show user list to admin" do
      admin = FactoryGirl.create(:admin)
      sign_in admin
      get :index
      response.status.should == 200
      sign_out admin
    end
    it "should not show user list to user or editor" do
      editor = FactoryGirl.create(:editor)
      user = FactoryGirl.create(:user)
      sign_in editor
      get :index
      response.status.should == 302
      sign_out editor
      sign_in user
      get :index
      response.status.should == 302
      sign_out user
    end
  end

  describe "test if only admins can read users' information and update their status" do
    before :each do
      @admin = FactoryGirl.create(:admin)
      @user = FactoryGirl.create(:user)
    end
    it "should show user's information to admin" do
      sign_in @admin
      get :index, :id => 1
      response.status.should == 200
      sign_out @admin
    end

    it "should locate the requested user and update status for admin" do
      sign_in @admin
      put :update_status, :id => @user.id, user: FactoryGirl.attributes_for(:user, status: "editor")
      assigns(:user).should eq(@user)
      @user.reload
      @user.status.should == "editor"
      sign_out @admin
    end

    it "should not update user's status for common user" do
      sign_in @user
      put :update_status, :id => @user.id, user: FactoryGirl.attributes_for(:user, status: "editor")
      @user.reload
      @user.status.should_not == "editor"
      sign_out @user
    end

    it "should update other attributes of current user's profile but no status" do
      sign_in @user
      put :update, :id => @user.id, :user => {"name" => "new_name", "email" => "new@email.com", "status" => "alien"}
      @user.reload
      @user.status.should_not == "alien"
      @user.status.should == "user"
      @user.name.should == "new_name"
      @user.email.should == "new@email.com"
      sign_out @user
    end

  end

  describe "test if current user can edit his own profile" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    it "should show edit page for current user's own profile" do
      get :edit, :id => @user.id
      response.should render_template("edit")
    end

    it "should not show edit page for another user's profile" do
      other = FactoryGirl.create(:user)
      sign_in @user
      get :edit, :id => other.id 
      response.should_not render_template("edit")
      response.should redirect_to root_path
    end
  end

  describe "test if can delete a user" do
    before :each do
      @user = FactoryGirl.create(:user)
    end
    it "should delete a user" do
      pending
      delete :destroy, :id => @user.id
      User.find(@user.id).should be_nil
      response.should redirect_to users_path
    end
  end


end
