module Admin
  class ApplicationController < ActiveAdmin::BaseController
    http_basic_authenticate_with name: "admin", password: "password"
  end
end