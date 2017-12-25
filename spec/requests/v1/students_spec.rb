require 'rails_helper'

RSpec.describe "Students", type: :request do
  before { host! 'api.fractal-technology.dev' }
  let(:student){ create(:student) }
  let(:student_id){ student.id }

  let(:headers) do
    {
      'Accept' => 'application/vnd.course-management.v1',
      'Content-Type' => Mime[:json].to_s,
    }
  end

  describe 'GET /students' do
    before do
      @student = create(:student)
      get "/students", params: {}, headers: headers
    end

    context 'when there are students' do
      it 'returns status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'does not return an empty data array' do
        expect(json_body.dig(:data)).not_to be_empty
      end

      it 'returns json data as per json:api spec' do
        expect(json_body).to be_collection_jsonapi_match('students')
      end
    end
  end

  describe 'GET /students/:id' do
    let(:included_associations){ nil }
    before do
      get "/students/#{student_id}", params: {include: included_associations}, headers: headers
    end

    context 'when the student exists' do
      it 'returns the student' do
        expect(json_body.dig(:data, :id).to_i).to eq(student_id)
      end

      it 'returns status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns json data as per json:api spec' do
        expect(json_body).to be_jsonapi_match('students')
      end
    end

    context 'when student does not exist' do
      let(:student_id){ 99999999 }
      it 'returns status 404' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when student has associations' do
      let(:included_associations){ 'courses' }
      let(:student_id){ create(:student, :with_courses).id }

      it 'returns json data with associations as per json:api spec' do
        expect(json_body).to be_jsonapi_assoc_match('students')
      end
    end
  end

  describe 'POST /students/' do
    before do
      post "/students/", params: {
        data: {
          type: 'students',
          attributes: student_params
        }
      }.to_json, headers: headers
    end

    context 'When the request params are valid' do
      let(:student_params){ attributes_for(:student, name: 'Jimmy Fellow') }

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the location redirect as being the path to the created student' do
        expect(response.headers['Location']).to match(/\/students\/\d/)
      end

      it 'returns json data as per json:api spec' do
        expect(json_body).to be_jsonapi_match('students')
      end
    end

    context 'When the request params are invalid' do
      let(:student_params){ attributes_for(:student, name: nil, email: nil) }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns json data with errors' do
        expect(json_body).to have_jsonapi_errors_for('/data/attributes/email')
      end
    end
  end

  describe 'PUT /students/:id' do
    before do
      put "/students/#{student_id}", params: {
        data: {
          type: 'students',
          id: student_id,
          attributes: student_params
        }
      }.to_json, headers: headers
    end

    context 'when the request params are valid' do
      let(:student_params){ { name: 'Jimmy Fellow', email: 'jimmyfellow@gmail.com' } }

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the location redirect as being the path to the created student' do
        expect(response.headers['Location']).to match(/\/students\/\d/)
      end

      it 'returns json data as per json:api spec' do
        expect(json_body).to be_jsonapi_match('students')
      end
    end

    context 'when the request params are invalid' do
      let(:student_params){ { name: '', email: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns json data with errors' do
        expect(json_body).to have_jsonapi_errors_for('/data/attributes/email')
      end
    end
  end

  describe "DELETE /students/:id" do
    before do
      delete "/students/#{student_id}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end

    it 'checks the student does not exist in the database anymore' do
      expect(Student.find_by(id: student_id)).to be_nil
    end
  end
end
