require 'rails_helper'

RSpec.describe RemoveAndNotifyEntityJob, type: :job do
  let(:relation){ double(:relation, remove: nil) }
  let(:course){ double(:course, teachers: relation, students: relation) }
  let(:teacher){ double(:teacher) }
  let(:student){ double(:student) }

  it 'assigns teacher and student to the related course' do
    expect(relation).to receive(:remove).twice

    described_class.perform_now(course, teacher, student)
  end

end
