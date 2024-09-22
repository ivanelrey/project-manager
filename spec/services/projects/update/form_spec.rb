# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Projects::Update::Form do
  subject { described_class.new(project) }

  describe '#valid?' do
    context 'with valid project' do
      let(:project) { build(:project) }

      it 'is valid' do
        expect(subject.valid?).to be true
      end
    end

    context 'when status is incorrect' do
      let(:project) { build(:project, status: 'wrong') }

      it 'is invalid' do
        expect(subject.valid?).to be false
        expect(subject.errors.messages.keys).to include :status
      end
    end
  end
end
