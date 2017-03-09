module Rallio
  describe Review do
    let(:token) { access_token[:access_token] }
    let(:headers) { { 'Authentication' => "Bearer #{token}" } }
    let(:parsed_response) { reviews_response }
    let(:api_response) { double(:api_response, parsed_response: parsed_response) }

    subject { described_class.new(access_token: token, **parsed_response) }

    before do
      allow(described_class).to receive(:get).and_return(api_response)
    end

    describe '.all' do
      let(:path) { "/#{type}/#{id}/reviews" }
      let(:type) { :accounts }
      let(:id) { 9397 }

      it 'returns an array with Review objects' do
        results = described_class.all(type: type, id: id, access_token: token)
        expect(results).to include(a_kind_of(Review))
      end

      context 'accounts' do
        it 'calls out to get reviews for account id' do
          expect(described_class).to receive(:get).with(path, headers: headers)
          described_class.all(type: type, id: id, access_token: token)
        end
      end

      context 'franchisors' do
        let(:type) { :franchisors }

        it 'calls out to get reviews for franchisor id' do
          expect(described_class).to receive(:get).with(path, headers: headers)
          described_class.all(type: type, id: id, access_token: token)
        end
      end
    end

    describe '#reply' do
      let(:reply) { "this is my reply" }
      let(:headers) do
        { 'Authentication' => "Bearer #{token}" }
      end

      it 'calls out to send passed in reply string' do
        expect(described_class).to receive(:post)
          .with("/reviews/#{subject.id}/reply", headers: headers, body: { message: reply })

        subject.reply(reply)
      end
    end
  end
end
