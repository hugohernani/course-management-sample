require 'rails_helper'

RSpec.describe "Courses", type: :request do
  before { host! 'api.fractal-technology.dev' }
  let(:course_id){ create(:course).id }
  let(:teacher_id){ create(:teacher).id }
  let(:student_id){ create(:student).id }

  let(:assign_params){ {course_id: course_id, teacher_id: teacher_id, student_id: student_id} }

  let(:headers) do
    {
      'Accept' => 'application/vnd.course-management.v1',
      'Content-Type' => Mime[:json].to_s,
    }
  end

  describe 'POST /courses/assign_entity' do
    before do
      post "/courses/assign_entity", params: {
        data: {
          type: 'queue-jobs',
          attributes: assign_params
        }
      }.to_json, headers: headers
    end

    it 'returns status 202' do
      expect(response).to have_http_status(:accepted)
    end

    it 'does not return an empty data' do
      expect(json_body.dig(:data)).not_to be_empty
    end

    it 'returns json data as per json:api spec' do
      expect(json_body).to be_jsonapi_match('queue-jobs')
    end
  end

  describe 'POST /courses/unassign_entity' do
    before do
      delete "/courses/unassign_entity", params: {
        data: {
          type: 'queue-jobs',
          attributes: assign_params
        }
      }, headers: headers
    end

    it 'returns status 202' do
      expect(response).to have_http_status(:accepted)
    end

    it 'does not return an empty data' do
      expect(json_body.dig(:data)).not_to be_empty
    end

    it 'returns json data as per json:api spec' do
      expect(json_body).to be_jsonapi_match('queue-jobs')
    end
  end
end
