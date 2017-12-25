require 'rails_helper'

RSpec.describe 'Teachers API', type: :request do
  before { host! 'api.fractal-technology.dev' }
  let(:teacher){ create(:teacher) }
  let(:teacher_id){ teacher.id }

  let(:headers) do
    {
      'Accept' => 'application/vnd.course-management.v1',
      'Content-Type' => Mime[:json].to_s,
    }
  end

  describe 'GET /teachers' do
    before do
      @teacher = create(:teacher)
      get "/teachers", params: {}, headers: headers
    end

    context 'when there are teachers' do
      it 'returns status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'does not return an empty data array' do
        expect(json_body.dig(:data)).not_to be_empty
      end

      it 'returns json data as per json:api spec' do
        expect(json_body).to be_collection_jsonapi_match('teachers')
      end
    end
  end

  describe 'GET /teachers/:id' do
    let(:included_associations){ nil }
    before do
      get "/teachers/#{teacher_id}", params: {include: included_associations}, headers: headers
    end

    context 'when the teacher exists' do
      it 'returns the teacher' do
        expect(json_body.dig(:data, :id).to_i).to eq(teacher_id)
      end

      it 'returns status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns json data as per json:api spec' do
        expect(json_body).to be_jsonapi_match('teachers')
      end
    end

    context 'when teacher does not exist' do
      let(:teacher_id){ 99999999 }
      it 'returns status 404' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when teacher has associations' do
      let(:included_associations){ 'courses' }
      let(:teacher_id){ create(:teacher, :with_courses).id }

      it 'returns json data with associations as per json:api spec' do
        expect(json_body).to be_jsonapi_assoc_match('teachers')
      end
    end
  end

  describe 'POST /teachers/' do
    before do
      post "/teachers/", params: {
        data: {
          type: 'teachers',
          attributes: teacher_params
        }
      }.to_json, headers: headers
    end

    context 'When the request params are valid' do
      let(:teacher_params){ attributes_for(:teacher, name: 'Jack Sparrow') }

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the location redirect as being the path to the created teacher' do
        expect(response.headers['Location']).to match(/\/teachers\/\d/)
      end

      it 'returns json data as per json:api spec' do
        expect(json_body).to be_jsonapi_match('teachers')
      end
    end

    context 'When the request params are invalid' do
      let(:teacher_params){ attributes_for(:teacher, name: nil) }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns json data with errors' do
        expect(json_body).to have_jsonapi_errors_for('/data/attributes/name')
      end
    end
  end

  describe 'PUT /teachers/:id' do
    before do
      put "/teachers/#{teacher_id}", params: {
        data: {
          type: 'teachers',
          id: teacher_id,
          attributes: teacher_params
        }
      }.to_json, headers: headers
    end

    context 'when the request params are valid' do
      let(:teacher_params){ { name: 'Jack Sparrow' } }

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the location redirect as being the path to the created teacher' do
        expect(response.headers['Location']).to match(/\/teachers\/\d/)
      end

      it 'returns json data as per json:api spec' do
        expect(json_body).to be_jsonapi_match('teachers')
      end
    end

    context 'when the request params are invalid' do
      let(:teacher_params){ { name: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns json data with errors' do
        expect(json_body).to have_jsonapi_errors_for('/data/attributes/name')
      end
    end
  end

  describe "DELETE /teachers/:id" do
    before do
      delete "/teachers/#{teacher_id}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end

    it 'checks the teacher does not exist in the database anymore' do
      expect(Teacher.find_by(id: teacher_id)).to be_nil
    end
  end
end
