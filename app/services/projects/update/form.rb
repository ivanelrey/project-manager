# frozen_string_literal: true

module Projects
  module Update
    class Form
      include ActiveModel::Model

      validates :status, inclusion: { in: Project::STATUSES.map(&:to_s) }

      def initialize(comment)
        @comment = comment
      end

      private

      attr_reader :comment

      delegate :status, to: :comment, private: true
    end
  end
end
