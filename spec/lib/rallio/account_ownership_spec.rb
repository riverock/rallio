module Rallio
  describe AccountOwnership do
    let(:parsed_response) { account_ownerships_response }
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
        expect(described_class).to receive(:get).with('/account_ownerships', headers: headers)
        described_class.for(access_token: token)
      end

      it 'returns and array of AccountOwnerships' do
        expect(described_class.for(access_token: token)).to include(a_kind_of(AccountOwnership))
      end
    end

    describe '.create' do
      let(:parsed_response) { account_ownership_response }
      let(:user) { Rallio::User.new(user_response) }
      let(:headers) do
        {
          'X-Application-ID' => Rallio.application_id,
          'X-Application-Secret' => Rallio.application_secret
        }
      end

      it 'calls out to create an ownership for the given user id' do
        expect(described_class).to receive(:post).with("/users/#{user.id}/account_ownerships", headers: headers)
        described_class.create(user_id: user.id)
      end

      it 'returns an AccountOwnership' do
        expect(described_class.create(user_id: user.id)).to be_a(AccountOwnership)
      end
    end
  end
end
