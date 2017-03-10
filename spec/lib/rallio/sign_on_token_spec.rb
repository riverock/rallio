module Rallio
  describe SignOnToken do
    let(:parsed_response) { sign_on_tokens_response }
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
      let(:user_id) { 100 }

      it 'calls out to create sign on token for user id' do
        expect(described_class).to receive(:post).with("/users/#{user_id}/sign_on_tokens", headers: headers)
        described_class.create(user_id: user_id)
      end

      it 'returns a SignOnToken object' do
        puts described_class.create(user_id: user_id).inspect
        expect(described_class.create(user_id: user_id).token).to eq sign_on_tokens_response['sign_on_token']['token']
      end
    end
  end
end
