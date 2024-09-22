# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Projects::Create::Form do
  subject { described_class.new(project) }

  describe '#valid?' do
    context 'with valid project' do
      let(:project) { build(:project) }

      it 'is valid' do
        expect(subject.valid?).to be true
      end
    end

    context 'when name is missing' do
      let(:project) { build(:project, name: nil) }

      it 'is invalid' do
        expect(subject.valid?).to be false
        expect(subject.errors.messages.keys).to include :name
      end
    end

    context 'when description is missing' do
      let(:project) { build(:project, description: nil) }

      it 'is invalid' do
        expect(subject.valid?).to be false
        expect(subject.errors.messages.keys).to include :description
      end
    end
  end
end
