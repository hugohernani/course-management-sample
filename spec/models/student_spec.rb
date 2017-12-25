require 'rails_helper'

RSpec.describe Student, type: :model do
  context 'Validations' do
    [:name, :email].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end
  end
end
