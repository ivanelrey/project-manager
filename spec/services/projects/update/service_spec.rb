# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Projects::Update::Service do
  subject { described_class.new(project_id, params).call }

  let(:project) { create(:project, status: 'draft') }
  let(:project_id) { project.id }
  let(:params) { { status: 'completed' } }

  describe '#call' do
    context 'with valid params' do
      it 'updates the project status' do
        subject
        expect(project.reload.status).to eq params[:status]
      end

      context 'when status is being updated' do
        let(:expected_comment_body) { "User has changed the project status from 'draft' to 'completed'." }

        it 'creates a comment about the change' do
          expect { subject }.to change(Comment, :count).by 1

          last_project_commment = project.comments.last
          expect(last_project_commment.body).to eq expected_comment_body
        end
      end

      context 'when status does not change' do
        let(:params) { { status: 'draft' } }

        it 'does not create a comment' do
          expect { subject }.not_to change(Comment, :count)
        end
      end
    end

    context 'with invalid params' do
      let(:params) { { status: 'wrong' } }

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
