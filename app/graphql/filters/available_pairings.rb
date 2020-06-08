  class Filters::AvailablePairings
    # include SearchObject for GraphQL
    include SearchObject.module(:graphql)

    # scope is starting point for search
    scope { Pairing.all }

    type types[Types::PairingType]

    # inline input type definition for the advanced filter
    class PairingFilter < ::Types::BaseInputObject
      argument :OR, [self], required: false
      argument :program, String, required: false
      argument :module, Integer, required: false
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
      scope = Pairing.all
      scope = scope.where('date LIKE ?', "%#{value[:date]}%") if value[:date]
      scope = scope.where('pairee_id IS NULL')

      users = User.all
      users = users.where('program LIKE ?', "%#{value[:program]}%") if value[:program]
      users = users.where('mod = ?', value[:module]) if value[:module]
      user_ids = users.map { |user| user.id}

      scope = scope.where(pairer_id: [user_ids])

      branches << scope

      value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

      branches
    end
  end
