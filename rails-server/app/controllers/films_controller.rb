# frozen_string_literal: true

class FilmsController < ApplicationController
  include Response
  include ExceptionHandler

  def index
    json_response(Film.all)
  end
end
