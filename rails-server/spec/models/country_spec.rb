# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Country, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
  end
end
