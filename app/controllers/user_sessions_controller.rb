class UserSessionsController < ApplicationController
  layout nil

  def new
    @user_session = UserSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_session }
    end
  end

  def create
    @user_session = UserSession.new(params[:user_session])

    if @user_session.save
      flash[:notice] = "You are Logged in Successfully."
      redirect_to(:controller=>'generals',:action=>'index')
    else
      flash[:error] = "Please check Username and Password "
      render :action => :new
    end
  end

  def destroy
    @user_session = UserSession.find(params[:id])
    @user_session.destroy

    respond_to do |format|
      format.html { redirect_to(new_user_session_url, :notice => 'Goodbye!') }
      format.xml  { head :ok }
    end
  end
end
