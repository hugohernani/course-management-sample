require 'rails_helper'

RSpec.describe CourseRelation, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:entity) }
    it { is_expected.to belong_to(:course) }
  end
end
