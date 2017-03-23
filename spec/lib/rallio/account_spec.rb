module Rallio
  describe Account do
    let(:account) { Rallio::Account.new(id: 9397) }
    let(:token) { access_tokens_response['access_token'] }
    let(:parsed_response) { accounts_response }
    let(:api_response) { double(:api_response, parsed_response: parsed_response) }

    before do
      Rallio.application_id = 'foobar'
      Rallio.application_secret = 'bizbaz'
      allow(described_class).to receive(:get).and_return(api_response)
      allow(described_class).to receive(:post).and_return(api_response)
    end

    subject { account }

    describe '.for' do
      let(:franchisor_id) { 200 }
      let(:headers) do
        {
          'X-Application-ID' => Rallio.application_id,
          'X-Application-Secret' => Rallio.application_secret
        }
      end

      it 'calls out to get account for franchisor_id' do
        expect(described_class).to receive(:get).with("/franchisors/#{franchisor_id}/accounts", headers: headers)
        described_class.for(franchisor_id: franchisor_id)
      end

      it 'returns an array with Account objects' do
        expect(described_class.for(franchisor_id: franchisor_id)).to include(a_kind_of(Rallio::Account))
      end
    end

    describe '.create' do
      let(:franchisor_id) { 200 }
      let(:headers) do
        {
          'X-Application-ID' => Rallio.application_id,
          'X-Application-Secret' => Rallio.application_secret
        }
      end
      let(:account) do
        {
          name: 'Awesome Test Account',
          short_name: 'ATA-1',
          url: 'https://ata.example',
          city: 'Narnia',
          country_code: 'US',
          time_zone: 'Central Time (US & Canada)'
        }
      end
      let(:parsed_response) { { account: account } }

      it 'calls out to create a new account' do
        expect(described_class).to receive(:post).with("/franchisors/#{franchisor_id}/accounts", headers: headers, body: { account: account })
        described_class.create(franchisor_id: franchisor_id, account: account)
      end

      it 'returns has of created record' do
        expect(described_class.create(franchisor_id: franchisor_id, account: account)).to be_a Rallio::Account
      end
    end

    describe '#reviews' do
      it 'calls all on Review to get reviews' do
        expect(Review).to receive(:all).with(type: :accounts, id: account.id, access_token: token)
        subject.reviews(access_token: token)
      end
    end
  end
end
