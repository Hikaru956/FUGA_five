# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  layout 'bs'
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  #def update
  #  poipoi
  #   super
  #   user = User.find_by(id: params[:user][:id])
  #   redirect_to :action=>"company_show_user", :id=>user
  #end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
