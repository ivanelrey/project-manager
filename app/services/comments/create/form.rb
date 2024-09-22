# frozen_string_literal: true

module Comments
  module Create
    class Form
      include ActiveModel::Model

      validates :project, presence: true
      validates :body, presence: true

      def initialize(comment)
        @comment = comment
      end

      private

      attr_reader :comment

      delegate :project, :body, to: :comment, private: true
    end
  end
end
