require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe 'validations' do
    it { should validate_exclusion_of(:name).in_array([nil]) }
  end

  describe 'relationships' do
    it { should belong_to :user }
  end
end
