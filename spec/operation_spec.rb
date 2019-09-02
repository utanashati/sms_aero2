RSpec.describe SmsAero2::Operation do
  describe "#call" do
    subject(:call_operation) { described_class.new(request, 'some_url', foo: :baz).call }

    let(:request) { double(:mock_reqest, call: body) }
    let(:body) do
      {
          'success' => true,
          'message' => '',
          'data' => {}
      }
    end

    before do
      allow(request).to receive(:call).and_return(body)
    end

    it 'calls request' do
      url = URI("https://gate.smsaero.ru/v2/some_url")
      expect(request).to receive(:call).with(url, foo: :baz)
      call_operation
    end

    it 'returns result' do
      expect(subject).to an_instance_of(SmsAero2::Result)
    end

    it 'create result with response' do
      allow(SmsAero2::Result).to receive(:new)
      expect(SmsAero2::Result).to receive(:new).with(body)
      call_operation
    end
  end
end
