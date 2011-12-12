module Quby
  class AdminAreaController < ApplicationController
    layout 'admin_area'

    before_filter :authenticate_user!
  end
end
