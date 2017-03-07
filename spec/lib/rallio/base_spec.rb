module Rallio
  describe Base do
    it 'has the correct base_uri' do
      expect(described_class.base_uri).to eq 'https://app.rallio.com/api/v1'
    end
  end
end
