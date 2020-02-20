module Type
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :mod, String, null: false
    field :program, String, null: false
    field :pronouns, String, null: false
    field :slack, String, null: false
    field :email, String, null: false
    field :image, String, null: false
    field :phone_number, String, null: false
  end
end
