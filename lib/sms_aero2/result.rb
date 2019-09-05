module SmsAero2
  class Result
    attr_reader :response

    def initialize(response)
      @response = response
    end

    def success?
      response.fetch('success')
    end

    def reason
      response.fetch('message')
    end

    def data
      response.fetch('data')
    end
  end
end
