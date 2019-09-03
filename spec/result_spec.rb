RSpec.describe SmsAero2::Result do
  subject(:build_result) { described_class.new(response) }
  let(:response) do
    {
        'success' => true,
        'message' => '',
        'data' => {}
    }
  end

  it "returns success result", :aggregate_failures do
    result = build_result
    expect(result).to have_attributes(success?: true, reason: '')
  end
end
