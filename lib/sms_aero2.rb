require 'logger'
require "sms_aero2/error"
require "sms_aero2/version"
require "sms_aero2/request"

module SmsAero2
  class Client
    attr_accessor :login, :api_token, :logger

    def initialize(login:, api_token:, logger: Logger.new(STDOUT))
      @login = login
      @api_token = api_token
      @logger = logger
    end

    def send_sms(to:, from:, text:, type:)
    end

    def hlr_status(id:)
    end

    def hlr(phone:)
    end
  end
end
