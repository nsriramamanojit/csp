class UsersController < ApplicationController
  layout "admin"
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def new
    @user = User.new
    render :layout => "application"

  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  def profile
    @user = User.find(params[:id])
    render :layout => "application"
  end
  def edit_profile
    @user = User.find(params[:id])
    render :layout => "application"
  end
  def change_password
    @user = current_user
    render :layout => "application"

  end
  def update_password
    puts @user = current_user
    return flash.now[:error] = "Old password is not correct" unless @user.valid_password? params[:old_password]
    if params[:password] == params[:password_confirmation]
      @user.password =@user.password_confirmation= params[:password]
      if @user.save
        flash.now[:success] = "Password Changed Successfully."
      else
        flash.now[:error]= "Password not changed"
      end
    else
      flash.now[:error] = "New Password mismatch"
      @old_password = params[:old_password]
    end
  end
end
