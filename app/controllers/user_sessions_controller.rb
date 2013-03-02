class UserSessionsController < ApplicationController
  skip_before_filter :require_login, :except => [:destroy]

  def new
    @user = User.new
  end
  
  def create
    respond_to do |format|
      if @user = login(params[:username],params[:password])
        format.html { redirect_back_or_to(:tasks) }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { flash.now[:alert] = "Login failed."; render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
    
  def destroy
    logout
    redirect_to(:login, :notice => 'See ya next time.')
  end

  def guest
    # Note: reproducing the sorcery 'login' stuff here so we get what we need but skip actually trying to authenticate the user, etc.
    @current_user = nil
    user = User.new
    user.is_guest = true
    user.save
    old_session = session.dup.to_hash
    reset_session # protect from session fixation attacks
    old_session.each_pair do |k,v|
      session[k.to_sym] = v
    end
    form_authenticity_token

    auto_login(user)
    #after_login!(user, credentials)
    current_user

    redirect_to(:tasks)
  end
end

