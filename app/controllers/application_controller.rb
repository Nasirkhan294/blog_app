class ApplicationController < ActionController::Base
    def current_user
        user.first
    end
end
