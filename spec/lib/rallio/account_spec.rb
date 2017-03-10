module Rallio
  describe Account do
    let(:account) { Rallio::Account.new(id: 9397) }
    let(:token) { access_token['access_token'] }

    subject { account }

    describe '#reviews' do
      it 'calls all on Review to get reviews' do
        expect(Review).to receive(:all).with(type: :accounts, id: account.id, access_token: token)
        subject.reviews(access_token: token)
      end
    end
  end
end
