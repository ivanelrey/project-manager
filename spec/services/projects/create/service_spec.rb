# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Projects::Create::Service do
  subject { described_class.new(params).call }

  describe '#call' do
    context 'with valid params' do
      let(:params) { { name: 'test', description: 'test description' } }

      it 'creates the project' do
        expect { subject }.to change(Project, :count).by 1
        expect(subject.name).to eq params[:name]
        expect(subject.description).to eq params[:description]
      end
    end

    context 'with invalid params' do
      let(:params) { { name: 'test', description: nil } }

      it 'raises validation error' do
        expect { subject }.to raise_error(ActiveModel::ValidationError)
      end
    end
  end
end
