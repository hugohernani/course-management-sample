require 'rails_helper'

RSpec.describe Teacher, type: :model do
  context 'Validations' do
    [:name].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:course_relation) }
    it { is_expected.to have_many(:courses).through(:course_relation) }
  end
end
