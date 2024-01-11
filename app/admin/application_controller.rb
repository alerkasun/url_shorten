module Admin
  class ApplicationController < ActiveAdmin::BaseController
    http_basic_authenticate_with name: "admin", password: "password"

    def authenticate_admin
      authenticate_or_request_with_http_basic("Whatever") do |name, password|
        name == "admin" && password == "admin"
      end
    end

  end
end
