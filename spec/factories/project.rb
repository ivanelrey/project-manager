# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { 'test project' }
    description { 'test description' }
    status { 'draft' }
  end
end
