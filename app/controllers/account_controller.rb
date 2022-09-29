class AccountController < ApplicationController

    def index
        redirect_to new_user_session_path
    end

    def new
        redirect_to new_user_session_path
    end

    def create
        redirect_to new_user_session_path
    end

    def destroy
        redirect_to new_user_session_path
    end

end
