RSpec.describe SmsAero2::Request do
  describe "#call" do
    subject(:send_request) { described_class.new(client).call(url, params) }
    let(:client) { double(:client, logger: nil, login: 'foo', api_key: 'foo') }
    let(:url) { 'https://somehost.org' }
    let(:params) { {id: 123} }
    let(:body) { Hash[status: :ok].to_json }
    let(:status) { 200 }

    before do
      stub_request(:get, url).with(query: params).and_return(body: body, status: status)
    end

    it "sends get request to url" do
      send_request
      expect(WebMock).to have_requested(:get, url).with(query: params).once
    end

    context 'with server error' do
      let(:status) { 400 }

      it "raises error" do
        expect { subject }.to raise_error(SmsAero2::Request::HttpError)
      end
    end

    context "with invalid body" do
      let(:body) { 'Not found' }

      it "raises error" do
        expect { subject }.to raise_error(SmsAero2::Request::InvalidResponse)
      end
    end
  end
end
