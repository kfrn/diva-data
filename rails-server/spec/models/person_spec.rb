# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Person, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:imdb_id) }
  end

  context 'associations' do
    # it { should have_and_belong_to_many(:films) }
  end
end
