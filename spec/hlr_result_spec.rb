RSpec.describe SmsAero::HlrResult do
  subject(:build_result) { described_class.new(response) }
  let(:response) do
    {
        'success' => true,
        'message' => '',
        'data' => {'hlrStatus' => 4, 'id' => 'foo'}
    }
  end

  it "returns result with hlr status" do
    result = build_result
    expect(result).to have_attributes(status: :in_work, id: 'foo')
  end
end
