require 'search_object'
require 'search_object/plugin/graphql'

class Resolvers::PairingsSearch
  # include SearchObject for GraphQL
  include SearchObject.module(:graphql)

  # scope is starting point for search
  scope { Pairing.all }

  type [Types::PairingType]

  # inline input type definition for the advanced filter
  class PairingFilter < ::Types::BaseInputObject
    argument :OR, [self], required: false
    argument :program, String, required: false
    argument :mod, String, required: false
    argument :date, String, required: false
  end

  # when "filter" is passed "apply_filter" would be called to narrow the scope
  option :filter, type: PairingFilter, with: :apply_filter

  # apply_filter recursively loops through "OR" branches
  def apply_filter(scope, value)
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def normalize_filters(value, branches = [])
    scope = User.all
    scope = scope.where('program LIKE ?', "%#{value[:program]}%") if value[:program]
    scope = scope.where('mod LIKE ?', "%#{value[:mod]}%") if value[:mod]
    scope = scope.where('date LIKE ?', "%#{value[:date]}%") if value[:date]

    branches << scope

    value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

    branches
  end
end
