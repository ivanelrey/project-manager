# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comments::Create::Service do
  subject { described_class.new(project_id, params).call }

  let(:project) { create(:project, status: 'draft') }
  let(:project_id) { project.id }
  let(:params) { { body: 'test' } }

  describe '#call' do
    context 'with valid params' do
      it 'creates the project' do
        expect { subject }.to change(Comment, :count).by 1
        expect(subject.body).to eq params[:body]
        expect(subject.project_id).to eq project.id
      end
    end

    context 'with invalid params' do
      let(:params) { { body: nil } }

      it 'raises validation error' do
        expect { subject }.to raise_error(ActiveModel::ValidationError)
      end
    end

    context 'with project with project_id does not exist' do
      let(:project_id) { 0 }

      it 'raises validation error' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
