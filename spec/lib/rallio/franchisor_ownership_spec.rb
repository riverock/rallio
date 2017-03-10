module Rallio
  describe FranchisorOwnership do
    let(:parsed_response) { franchisor_ownerships_response }
    let(:api_response) { double(:api_response, parsed_response: parsed_response) }

    before do
      Rallio.application_id = 'foobar'
      Rallio.application_secret = 'bizbaz'
      allow(described_class).to receive(:get).and_return(api_response)
      allow(described_class).to receive(:post).and_return(api_response)
    end

    describe '.for' do
      let(:token) { access_tokens_response['access_token'] }
      let(:headers) { { 'Authorization' => "Bearer #{token}" } }

      it 'calls out to get account ownerships for the given access token' do
        expect(described_class).to receive(:get).with('/franchisor_ownerships', headers: headers)
        described_class.for(access_token: token)
      end

      it 'returns and array of FranchisorOwnerships' do
        expect(described_class.for(access_token: token)).to include(a_kind_of(FranchisorOwnership))
      end
    end
  end
end
