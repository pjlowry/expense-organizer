require 'spec_helper'

describe Tag do
  context 'validations' do
    it {should validate_presence_of :name}
    it {should ensure_length_of(:name).
        is_at_least(3).
        is_at_most(20)}
    it {should_not allow_value("SDF$#").for(:name)}
    it {should allow_value("rent/mortgage").for(:name)}
  end
end