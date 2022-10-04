# frozen_string_literal: true

require "dry/validation"

class SessionParamsContract < Dry::Validation::Contract
  params do
    required(:email)
    required(:password)
  end

  # https://dry-rb.org/gems/dry-validation/1.8/
  rule(:email) do
    key.failure( I18n.t(:missing_parameters, scope: 'api.errors') ) if values[:email].blank?  
  end
  rule(:password) do
    key.failure( I18n.t(:missing_parameters, scope: 'api.errors') ) if values[:password].blank?  
  end
end
