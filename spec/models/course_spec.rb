require 'rails_helper'

RSpec.describe Course, type: :model do
  context 'Validations' do
    [:title, :description].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end
  end
end
