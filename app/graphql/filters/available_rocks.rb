class Filters::AvailableRocks
    # include SearchObject for GraphQL
    include SearchObject.module(:graphql)

    # scope is starting point for search
    scope { User.all }

    type types[Types::UserType]

    # inline input type definition for the advanced filter
    class UserFilter < ::Types::BaseInputObject
      argument :OR, [self], required: false
      argument :program, String, required: false
      argument :module, Integer, required: false
    end

    # when "filter" is passed "apply_filter" would be called to narrow the scope
    option :filter, type: UserFilter, with: :apply_filter

    # apply_filter recursively loops through "OR" branches
    def apply_filter(scope, value)
      branches = normalize_filters(value).reduce { |a, b| a.or(b) }
      scope.merge branches
    end

    def normalize_filters(value, branches = [])
      scope = User.all
      scope = scope.where('program LIKE ?', "%#{value[:program]}%") if value[:program]
      scope = scope.where('mod = ?', value[:module]) if value[:module]
      scope = scope.where(rock_opt_in: true)
      users = scope.left_outer_joins(:pebble_roles).where(rock_and_pebbles: { rock_id: nil } )
      rock_and_pebbles = scope.left_outer_joins(:pebble_roles).where(rock_and_pebbles: {active: true}).group(:id).having('count(pebble_id) < 2')

      scope = users + rock_and_pebbles
      branches << scope

      value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

      branches
    end
  end
