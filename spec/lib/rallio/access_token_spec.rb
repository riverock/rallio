module Rallio
  describe AccessToken do
    let(:parsed_response) { access_token }
    let(:api_response) { double(:api_response, parsed_response: parsed_response) }

    before do
      Rallio.application_id = 'foobar'
      Rallio.application_secret = 'bizbaz'
      allow(described_class).to receive(:post).and_return(api_response)
    end

    describe '.create' do
      let(:headers) do
        {
          'X-Application-ID' => Rallio.application_id,
          'X-Application-Secret' => Rallio.application_secret
        }
      end
      let(:user_id) { access_token[:user_id] }

      it 'calls new with passed args' do
        expect(described_class).to receive(:post).with("/users/#{user_id}/access_token", headers: headers)
        described_class.create(user_id: user_id)
      end

      it 'returns an AccessToken object' do
        expect(described_class.create(user_id: user_id).to_hash).to eq access_token
      end
    end
  end
end
