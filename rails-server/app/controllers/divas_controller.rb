# frozen_string_literal: true

class DivasController < ApplicationController
  include Response
  include ExceptionHandler

  def index
    @divas = Person.where(diva: true)

    json_response(@divas)
  end
end
