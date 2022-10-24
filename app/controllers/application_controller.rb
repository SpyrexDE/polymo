class ApplicationController < ActionController::Base
  APPLICATION_TITLE = "mooted.org"
  add_flash_types :success, :info, :error, :warning
end
