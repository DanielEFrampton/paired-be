# module Mutations
#   module Users
#     class CreateUser < ::Mutations::BaseMutation
#
#     field :create_user, Types::UserType, null: true do
#        argument :name, String, required: true
#        argument :mod, String, required: true
#        argument :program, String, required: true
#        argument :pronouns, String, required: true
#        argument :slack, String, required: false
#        argument :email, String, required: true
#        argument :image, String, required: false
#        argument :phone_number, String, required: true
#
#      resolve ->(_obj, args, _ctx) do
#        User.create(
#          name: args[:name],
#          mod: args[:mod],
#          program: args[:program],
#          email: args[:email],
#          phone_number: args[:phone_number],
#        )
#        end
#      end
#    end
#   end
# end

class Mutations::Users::CreateUser < Mutations::BaseMutation
  null true

  argument :name, String, required: true
  argument :mod, String, required: true
  argument :program, String, required: true
  # argument :pronouns, String, required: true
  # argument :slack, String, required: false
  # argument :email, String, required: true
  # argument :image, String, required: false
  # argument :phone_number, String, required: true

  field :user, Types::UserType, null: true
  field :errors, [String], null: false

  def resolve(name:, mod:, program:)
    user = User.create(name: body, mod: mod, program: program)
    if user.save
      # Successful creation, return the created object with no errors
      {
        user: user,
        errors: [],
      }
    else
      # Failed save, return the errors to the client
      {
        user: nil,
        errors: comment.errors.full_messages
      }
    end
  end
end
