module SmsAero2
  class Operation
    BASE_URL = 'https://gate.smsaero.ru/v2/'.freeze
    attr_reader :request, :action_path, :params

    def initialize(request, action_path = '', **params)
      @request = request
      @action_path = action_path
      @params = params
    end

    def call
      result_class.new(request.call(url, **params))
    end

    private

    def url
      URI.join(BASE_URL, action_path)
    end

    def result_class
      SmsAero2::Result
    end
  end
end
