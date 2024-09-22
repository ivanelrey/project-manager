# frozen_string_literal: true

module Projects
  module Create
    class Form
      include ActiveModel::Model

      validates :name, presence: true
      validates :description, presence: true

      def initialize(project)
        @project = project
      end

      private

      attr_reader :project

      delegate :name, :description, :status, to: :project, private: true
    end
  end
end
