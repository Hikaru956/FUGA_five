class ReceptionController < ApplicationController
  before_action :authenticate_user!
  def index
  end
end
