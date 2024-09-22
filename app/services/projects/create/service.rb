# frozen_string_literal: true

module Projects
  module Create
    class Service
      def initialize(params)
        @params = params
      end

      def call
        project = Project.new(params)
        validate_project!(project)

        project.save!
        project
      end

      private

      attr_reader :params

      def validate_project!(project)
        Form.new(project).validate!
      end
    end
  end
end
