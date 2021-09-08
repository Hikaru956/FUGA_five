# -*- encoding : utf-8 -*-
#
# FUGA
# Copyright (c) 2014, 956 Inc.
#
# This software is released under the MIT License.
#
# http://opensource.org/licenses/mit-license.php
#

class TooltipController < ApplicationController
  skip_before_filter :verify_authenticity_token ,:only=>[:reservation]
  
  def reservation
    @item = Reservation.find(params[:id])
  rescue
    render "blank"
  end
end
