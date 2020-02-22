class PairedBeSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # Opt in to the new runtime (default in future graphql-ruby versions)
  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST

  # Add built-in connections for pagination
  use GraphQL::Pagination::Connections

#   input MutationInput {
#    name: String
#    mod: String
#    program: String
# }
#
# type Mutation {
#   createUser(input: MutationInput): String
# }
end
