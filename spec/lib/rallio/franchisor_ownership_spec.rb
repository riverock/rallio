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

    describe '.create' do
      let(:parsed_response) { franchisor_ownership_response }
      let(:user) { Rallio::User.new(user_response) }
      let(:headers) do
        {
          'X-Application-ID' => Rallio.application_id,
          'X-Application-Secret' => Rallio.application_secret
        }
      end
      let(:payload) { { franchisor_id: 200 } }

      it 'calls out to create an ownership for the given user id' do
        expect(described_class).to receive(:post).with("/users/#{user.id}/franchisor_ownerships", headers: headers, body: payload)
        described_class.create(user_id: user.id, payload: payload)
      end

      it 'returns an FranchisorOwnership' do
        expect(described_class.create(user_id: user.id, payload: payload)).to be_a(FranchisorOwnership)
      end
    end

    describe '.destroy' do
      let(:parsed_response) { nil }
      let(:user) { Rallio::User.new(user_response) }
      let(:headers) do
        {
          'X-Application-ID' => Rallio.application_id,
          'X-Application-Secret' => Rallio.application_secret
        }
      end
      let(:franchisor_id) { 200 }

      it 'calls out to destroy a FranchisorOwnership' do
        expect(described_class).to receive(:delete).with("/users/#{user.id}/franchisor_ownerships/#{franchisor_id}", headers: headers)
        described_class.destroy(user_id: user.id, object_id: franchisor_id)
      end
    end
  end
end
