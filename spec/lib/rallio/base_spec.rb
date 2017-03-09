module Rallio
  describe Base do
    describe '#initialize' do
      subject { described_class.new(access_token: 'token', id: 123) }

      its(:access_token) { is_expected.to eq 'token' }
    end

    it 'has the correct base_uri' do
      expect(described_class.base_uri).to eq 'https://app.rallio.com/api/v1'
    end
  end
end
