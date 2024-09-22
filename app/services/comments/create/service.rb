# frozen_string_literal: true

module Comments
  module Create
    class Service
      def initialize(project_id, params)
        @project = Project.find(project_id)
        @params = params
      end

      def call
        comment = Comment.new(params.merge(project:))
        validate_comment!(comment)

        comment.save!
        comment
      end

      private

      attr_reader :params, :project

      def validate_comment!(comment)
        Form.new(comment).validate!
      end
    end
  end
end
