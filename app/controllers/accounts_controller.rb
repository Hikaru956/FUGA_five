# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

# This controller handles the login/logout function of the site.  
class AccountsController < ApplicationController
  layout  "fuga"

  # render new.erb.html
  def new
    redirect_to new_user_session_path
  end

  def create
    redirect_to new_user_session_path
  end

  def destroy
    redirect_to new_user_session_path
  end

  def xxx_create
    logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user && user.try_count < USER_AUTH_FAIL_COUNT
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      
      ####
      ##  Reset Shop ID For Privilege Users
      #
      user.company    = nil if user.has_permission?(User::ROLE_OPERATOR) || user.has_permission?(User::ROLE_REGISTRAR)
      user.shop       = nil if user.has_permission?(User::ROLE_OWNER)
      user.try_count  = 0
      user.save!
      
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
#      redirect_back_or_default('/')
      redirect_to('/')
      flash[:notice] = "Logged in successfully"
    else
      note_failed_signin
      
      ###
      ## Increment Try Count
      #
      user = User.find_by_login(params[:login])
      unless user.blank?
        user.try_count = user.try_count+1
        user.save
      end
      
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def xxx_destroy
    #hikaru
    #logout_killing_session!
    flash[:notice] = "You have been logged out."
    #redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Couldn't log you in as '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
