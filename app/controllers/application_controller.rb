class ApplicationController < ActionController::Base
  APPLICATION_TITLE = "Polymo.org"
  add_flash_types :success, :info, :error, :warning
end
