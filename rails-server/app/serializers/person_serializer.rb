# frozen_string_literal: true

class PersonSerializer < ActiveModel::Serializer
  attributes :id, :name, :imdb_id, :diva, :director
end
