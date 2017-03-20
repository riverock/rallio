module Rallio
  describe Review do
    let(:token) { access_tokens_response[:access_token] }
    let(:headers) { { 'Authorization' => "Bearer #{token}" } }
    let(:parsed_response) { reviews_response }
    let(:api_response) { double(:api_response, parsed_response: parsed_response) }

    subject { described_class.new(parsed_response) }

    before do
      allow(described_class).to receive(:get).and_return(api_response)
    end

    describe '.all' do
      let(:object_params) { { account_id: '9397' } }
      let(:query_params) do
        {
          page: '2',
          network: 'google_places',
          start_date: (Time.now - 86400).iso8601,
          end_date: Time.now.utc.iso8601,
          rating: '4'
        }.merge(object_params)
      end

      it 'returns an array with Review objects' do
        results = described_class.all(query_params: query_params, access_token: token)
        expect(results).to include(a_kind_of(Review))
      end

      it 'allows query_params to be optional with {} as default' do
        expect(described_class).to receive(:get).with('/reviews', query: {}, headers: headers)
        described_class.all(access_token: token)
      end

      context 'accounts' do
        it 'calls out to get reviews for account id' do
          expect(described_class).to receive(:get).with('/reviews', query: query_params, headers: headers)
          described_class.all(query_params: query_params, access_token: token)
        end
      end

      context 'franchisors' do
        let(:object_params) { { franchisor_id: '9397' } }

        it 'calls out to get reviews for franchisor id' do
          expect(described_class).to receive(:get).with('/reviews', query: query_params, headers: headers)
          described_class.all(query_params: query_params, access_token: token)
        end
      end
    end

    describe '#reply' do
      let(:reply) { "this is my reply" }
      let(:headers) do
        { 'Authorization' => "Bearer #{token}" }
      end

      it 'calls out to send passed in reply string' do
        expect(described_class).to receive(:post)
          .with("/reviews/#{subject.id}/reply", headers: headers, body: { message: reply })

        subject.reply(message: reply, access_token: token)
      end
    end
  end
end
