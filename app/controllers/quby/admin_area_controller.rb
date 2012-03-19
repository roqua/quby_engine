module Quby
  class AdminAreaController < Quby::ApplicationController
    layout 'admin_area'

    before_filter :authenticate_user!
  end
end
