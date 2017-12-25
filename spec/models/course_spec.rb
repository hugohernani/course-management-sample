require 'rails_helper'

RSpec.describe Course, type: :model do
  context 'Validations' do
    [:title, :description].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:course_relation) }
    it { is_expected.to have_many(:students).through(:course_relation).source(:entity) }
    it { is_expected.to have_many(:teachers).through(:course_relation).source(:entity) }
  end
end
