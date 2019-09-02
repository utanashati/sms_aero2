module SmsAero
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

    private

    def data
      response.fetch('data')
    end
  end
end
