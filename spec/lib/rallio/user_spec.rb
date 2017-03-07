module Rallio
  describe User do
    let(:parsed_response) { Hash.new }
    let(:api_response) { double(:api_response, parsed_response: parsed_response) }

    before do
      Rallio.application_id = 'foobar'
      Rallio.application_secret = 'bizbaz'
      allow(described_class).to receive(:get).and_return(api_response)
      allow(described_class).to receive(:post).and_return(api_response)
    end

    describe '.accessible_users' do
      let(:headers) do
        {
          'X-Application-ID' => Rallio.application_id,
          'X-Application-Secret' => Rallio.application_secret
        }
      end
      let(:parsed_response) { accessible_users }

      it 'calls out to get accessible users for app' do
        expect(described_class).to receive(:get).with('/accessible_users', headers: headers)
        described_class.accessible_users
      end

      it 'returns an array' do
        expect(described_class.accessible_users).to be_a Array
      end

      it 'contains an array with User objects' do
        expect(described_class.accessible_users).to include(a_kind_of(User))
      end
    end

    describe '#sign_on_tokens' do
      let(:headers) do
        {
          'X-Application-ID' => Rallio.application_id,
          'X-Application-Secret' => Rallio.application_secret
        }
      end
      let(:parsed_response) { sign_on_token }
      let(:user) { described_class.new(accessible_users[:users].first) }

      it 'calls out to get a single sign on token' do
        expect(described_class).to receive(:post).with("/users/#{user.id}/sign_on_tokens", headers: headers)
        user.sign_on_tokens
      end

      it 'returns a SignOnToken' do
        expect(user.sign_on_tokens).to be_a SignOnToken
      end
    end

    describe '#access_token' do
      let(:token) { Rallio::AccessToken.new(access_token) }

      subject { described_class.new(accessible_users[:users].first) }

      before do
        allow(AccessToken).to receive(:create).and_return(token)
      end

      it 'creates and instance of AccessToken with user id' do
        expect(AccessToken).to receive(:create).with(user_id: subject.id)
        subject.access_token
      end

      it 'returns an AccessToken instance' do
        expect(subject.access_token).to be_a Rallio::AccessToken
      end

      it 'sets the @access_token ivar' do
        subject.access_token
        expect(subject.instance_variable_get(:@access_token)).to eq token
      end
    end
  end
end
