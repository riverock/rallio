module Rallio
  describe Franchisor do
    let(:franchisor) { Rallio::Franchisor.new(id: 9397) }
    let(:token) { access_token['access_token'] }
    let(:parsed_response) { franchisors_response }
    let(:api_response) { double(:api_response, parsed_response: parsed_response) }

    before do
      Rallio.application_id = 'foobar'
      Rallio.application_secret = 'bizbaz'
      allow(described_class).to receive(:get).and_return(api_response)
    end

    subject { franchisor }

    describe '.all' do
      let(:headers) do
        {
          'X-Application-ID' => Rallio.application_id,
          'X-Application-Secret' => Rallio.application_secret
        }
      end

      it 'calls out to get all franchisors for the app credentials' do
        expect(described_class).to receive(:get).with('/franchisors', headers: headers)
        described_class.all
      end

      it 'returns array with Franchisor objects' do
        expect(described_class.all).to include(a_kind_of(Franchisor))
      end
    end

    describe '#accounts' do
      let(:headers) do
        {
          'X-Application-ID' => Rallio.application_id,
          'X-Application-Secret' => Rallio.application_secret
        }
      end
      let(:parsed_response) { accounts_response }

      it 'calls out to get all accounts for franchisor' do
        expect(described_class).to receive(:get).with("/franchisors/#{subject.id}/accounts", headers: headers)
        subject.accounts
      end

      it 'returns array with Account objects' do
        expect(subject.accounts).to include(a_kind_of(Account))
      end
    end

    describe '#reviews' do
      it 'calls all on Review to get reviews' do
        expect(Review).to receive(:all).with(type: :franchisors, id: franchisor.id, access_token: token)
        subject.reviews(access_token: token)
      end
    end
  end
end
