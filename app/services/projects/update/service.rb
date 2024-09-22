# frozen_string_literal: true

module Projects
  module Update
    class Service
      def initialize(project_id, params)
        @project = Project.find(project_id)
        @params = params
      end

      def call
        old_status = project.status

        project.assign_attributes(params)
        validate_project!(project)

        ActiveRecord::Base.transaction do
          project.save!
          create_status_change_comment(old_status)
        end

        project
      end

      private

      attr_reader :params, :project

      def validate_project!(project)
        Form.new(project).validate!
      end

      def create_status_change_comment(old_status)
        return unless status_changed?(old_status)

        body = "User has changed the project status from '#{old_status}' to '#{project.status}'."
        Comments::Create::Service.new(project.id, { body: }).call
      end

      def status_changed?(old_status)
        old_status != project.status
      end
    end
  end
end
