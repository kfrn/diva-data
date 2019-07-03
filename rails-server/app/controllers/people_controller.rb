# frozen_string_literal: true

class PeopleController < ApplicationController
  include Response
  include ExceptionHandler

  def index
    @people = Person.all

    json_response(@people)
  end

  def show
    @person = Person.find(params[:id])

    json_response(@person)
  end
end
