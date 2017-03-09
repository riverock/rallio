module Rallio
  describe Franchisor do
    let(:franchisor) { Rallio::Franchisor.new(id: 9397) }
    let(:token) { access_token[:access_token] }

    subject { franchisor }

    describe '#reviews' do
      it 'calls all on Review to get reviews' do
        expect(Review).to receive(:all).with(type: :franchisors, id: franchisor.id, access_token: token)
        subject.reviews(access_token: token)
      end
    end
  end
end
