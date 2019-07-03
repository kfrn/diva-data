# frozen_string_literal: true

class DirectorsController < ApplicationController
  include Response
  include ExceptionHandler

  def index
    @directors = Person.where(director: true)

    json_response(@directors)
  end
end
