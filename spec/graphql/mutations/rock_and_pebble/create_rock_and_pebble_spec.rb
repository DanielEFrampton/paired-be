require 'rails_helper'
RSpec.describe 'create rp relationship', type: :request do
  describe 'resolve' do
    before :each do
      @user_1 = create :user
      @user_2 = create :user
      
      @query = <<~GQL
                mutation {
                  rock_and_pebble: CreateRockPebbleRelationship
                }






              GQL
    end
  end
end
