# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    project
    body { 'test body' }
  end
end
