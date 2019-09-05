RSpec.describe SmsAero2::Client do
  let(:client) { described_class.new(token: 123, login: 'some_login') }
  let(:body) do
    {
        success: success,
        data: data,
        message: message
    }.to_json
  end
  let(:success) { true }
  let(:data) { {} }
  let(:message) { nil }
  let(:status) { 200 }
  let(:number) { '78889996655' }
  let(:name) { 'Test' }
  let(:text) { 'Message body' }
  let(:channel) { :international }
  let(:url) { "https://gate.smsaero.ru/v2/#{path}" }

  before do
    stub_request(:get, url).with(query: params).and_return(body: body, status: status)
  end

  describe "#send_sms" do
    subject(:perform_request) do
      client.send_sms(to: number, from: name, text: text, channel: channel)
    end

    let(:path) { 'sms/send' }
    let(:params) do
      {
          number: number,
          sign: name,
          text: text,
          channel: 'INTERNATIONAL'
      }
    end

    it 'return success result' do
      expect(subject.success?).to eq(true)
    end

    context 'with error' do
      let(:success) { false }
      let(:message) { 'Error' }

      it 'return success result', :aggregate_failures do
        expect(subject.success?).to eq(false)
        expect(subject.reason).to eq('Error')
      end
    end
  end

  describe "#hlr" do
    subject(:perform_request) { client.hlr(phone: number) }

    let(:path) { 'hlr/check' }
    let(:params) do
      {
          number: number,
      }
    end
    let(:data) do
      { id: 123 }
    end

    it 'return success result', :aggregate_failures do
      expect(subject.success?).to eq(true)
      expect(subject.id).to eq(123)
    end
  end

  describe "#hlr_status" do
    subject(:perform_request) { client.hlr_status(id: 123) }

    let(:path) { 'hlr/status' }
    let(:params) do
      {
          id: 123
      }
    end
    let(:data) do
      {
          id: 123,
          number: "79131234567",
          hlrStatus: 1
      }
    end

    it 'return success result', :aggregate_failures do
      expect(subject.success?).to eq(true)
      expect(subject.id).to eq(123)
      expect(subject.status).to eq(:available)
    end
  end
end
