# frozen_string_literal: true

class Project < ApplicationRecord
  STATUSES = %i[draft in_progress completed].freeze

  has_many :comments, dependent: :destroy
end
