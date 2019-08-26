# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Person, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:imdb_id) }
  end
end
