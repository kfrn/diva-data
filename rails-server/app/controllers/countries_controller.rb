# frozen_string_literal: true

class CountriesController < ApplicationController
  include Response
  include ExceptionHandler

  def index
    json_response(Country.all)
  end
end
