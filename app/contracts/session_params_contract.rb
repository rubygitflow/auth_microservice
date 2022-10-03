# frozen_string_literal: true

require "dry/validation"

class SessionParamsContract < Dry::Validation::Contract
  params do
    required(:email).filled(:string)
    required(:password).filled(:string)
  end
end
