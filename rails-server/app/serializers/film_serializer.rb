# frozen_string_literal: true

class FilmSerializer < ActiveModel::Serializer
  attributes :id, :title, :year, :release_month, :release_year, :imdb_id
end
