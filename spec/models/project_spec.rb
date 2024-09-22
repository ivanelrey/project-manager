# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project do
  describe 'associations' do
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end
end
