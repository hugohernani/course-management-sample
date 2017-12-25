require 'rails_helper'

RSpec.describe "Courses", type: :request do
  before { host! 'api.fractal-technology.dev' }
  let(:course){ create(:course) }
  let(:course_id){ course.id }

  let(:headers) do
    {
      'Accept' => 'application/vnd.course-management.v1',
      'Content-Type' => Mime[:json].to_s,
    }
  end

  describe 'GET /courses' do
    before do
      @course = create(:course)
      get "/courses", params: {}, headers: headers
    end

    context 'when there are courses' do
      it 'returns status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'does not return an empty data array' do
        expect(json_body.dig(:data)).not_to be_empty
      end

      it 'returns json data as per json:api spec' do
        expect(json_body).to be_collection_jsonapi_match('courses')
      end
    end
  end

  describe 'GET /courses/:id' do
    before do
      get "/courses/#{course_id}", params: {}, headers: headers
    end

    context 'when the course exists' do
      it 'returns the course' do
        expect(json_body.dig(:data, :id).to_i).to eq(course_id)
      end

      it 'returns status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns json data as per json:api spec' do
        expect(json_body).to be_jsonapi_match('courses')
      end
    end

    context 'when the course does not exist' do
      let(:course_id){ 99999999 }
      it 'returns status 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /courses/' do
    before do
      post "/courses/", params: {
        data: {
          type: 'courses',
          attributes: course_params
        }
      }.to_json, headers: headers
    end

    context 'When the request params are valid' do
      let(:course_params){ attributes_for(:course, title: 'Rails API') }

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the location redirect as being the path to the created course' do
        expect(response.headers['Location']).to match(/\/courses\/\d/)
      end

      it 'returns json data as per json:api spec' do
        expect(json_body).to be_jsonapi_match('courses')
      end
    end

    context 'When the request params are invalid' do
      let(:course_params){ attributes_for(:course, title: nil, description: nil) }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns json data with errors' do
        expect(json_body).to have_jsonapi_errors_for('/data/attributes/title')
      end
    end
  end

  describe 'PUT /courses/:id' do
    before do
      put "/courses/#{course_id}", params: {
        data: {
          type: 'courses',
          id: course_id,
          attributes: course_params
        }
      }.to_json, headers: headers
    end

    context 'when the request params are valid' do
      let(:course_params){ { title: 'Rails API' } }

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the location redirect as being the path to the created course' do
        expect(response.headers['Location']).to match(/\/courses\/\d/)
      end

      it 'returns json data as per json:api spec' do
        expect(json_body).to be_jsonapi_match('courses')
      end
    end

    context 'when the request params are invalid' do
      let(:course_params){ { title: '', description: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns json data with errors' do
        expect(json_body).to have_jsonapi_errors_for('/data/attributes/title')
      end
    end
  end

  describe "DELETE /courses/:id" do
    before do
      delete "/courses/#{course_id}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end

    it 'checks the course does not exist in the database anymore' do
      expect(Course.find_by(id: course_id)).to be_nil
    end
  end
end
