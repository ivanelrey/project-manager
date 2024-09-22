# frozen_string_literal: true

module Projects
  module Update
    class Service
      def initialize(project_id, params)
        @project = Project.find(project_id)
        @params = params
      end

      def call
        project.assign_attributes(params)
        validate_project!(project)

        project.save!
        project
      end

      private

      attr_reader :params, :project

      def validate_project!(project)
        Form.new(project).validate!
      end
    end
  end
end
