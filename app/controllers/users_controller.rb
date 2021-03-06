class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  before_filter :authenticate_user!

  def index
    @users = User.all

    if admin?
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @users }
      end
    else 
      flash[:notice] = 'Access denied!'
      redirect_to root_path
    end

  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    if admin?
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    else
      flash[:notice] = 'Access denied!'
      redirect_to  root_path
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    if current_user.id == params[:id].to_i
      @user = User.find(params[:id])
      respond_to do |format|
        format.html # edit.html.erb
      end
    else
      flash[:notice] = 'Access denied!'
      redirect_to root_path
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { redirect_to root_path, notice: 'User was not created.' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if params[:user]["status"] && !admin?
      params[:user].delete("status")
    end
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to root_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to edit_user_path(@user), notice: 'Something went wrong.' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_status
    @user = User.find(params[:id])
    respond_to do |format|
      if admin?
        if @user.update_attributes(params[:user])
          format.html { redirect_to users_path, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { redirect_to user_path(@user), notice: 'Something went wrong.' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to root_path, notice: 'Access denied!' }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User #{@user.name} was successfully deleted." }
      format.json { head :no_content }
    end
  end
end
