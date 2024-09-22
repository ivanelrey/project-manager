# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comments::Create::Form do
  subject { described_class.new(comment) }

  describe '#valid?' do
    context 'with valid comment' do
      let(:comment) { build(:comment) }

      it 'is valid' do
        expect(subject.valid?).to be true
      end
    end

    context 'when project is missing' do
      let(:comment) { build(:comment, project: nil) }

      it 'is invalid' do
        expect(subject.valid?).to be false
        expect(subject.errors.messages.keys).to include :project
      end
    end

    context 'when body is missing' do
      let(:comment) { build(:comment, body: nil) }

      it 'is invalid' do
        expect(subject.valid?).to be false
        expect(subject.errors.messages.keys).to include :body
      end
    end
  end
end
