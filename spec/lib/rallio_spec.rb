describe Rallio do
  describe '.application_id=' do
    it 'sets @application_id' do
      Rallio.application_id = 'foobar'
      expect(Rallio.instance_variable_get(:@application_id)).to eq 'foobar'
    end
  end

  describe '.application_id' do
    it 'returns the value set via .application_id=' do
      Rallio.application_id = 'foobar'
      expect(Rallio.application_id).to eq 'foobar'
    end
  end

  describe '.application_secret=' do
    it 'sets @application_secret' do
      Rallio.application_secret = 'foobar'
      expect(Rallio.instance_variable_get(:@application_secret)).to eq 'foobar'
    end
  end

  describe '.application_secret' do
    it 'returns the value set via .application_secret=' do
      Rallio.application_secret= 'foobar'
      expect(Rallio.application_secret).to eq 'foobar'
    end
  end
end
