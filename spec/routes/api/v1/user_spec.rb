# frozen_string_literal: true

RSpec.describe AuthMicroservice, type: :routes do
  describe 'POST /api/v1/user' do
    context 'missing parameters' do
      it 'returns an error' do
        post '/api/v1/user', name: 'bob', email: 'bob@example.com', password: ''

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      it 'returns an error' do
        post '/api/v1/user', name: 'b.o.b', email: 'bob@example.com', password: 'givemeatoken'

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Use letters, numbers, or underscores for your name',
            'source' => {
              'pointer' => '/data/attributes/name'
            }
          }
        )
      end
    end

    context 'valid parameters' do
      it 'returns created status' do
        post '/api/v1/user', name: 'bob', email: 'bob@example.com', password: 'givemeatoken'

       expect(last_response.status).to eq(201)
      end
    end
  end
end
