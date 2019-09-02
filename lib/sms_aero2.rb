require 'logger'
require "sms_aero2/error"
require "sms_aero2/version"
require "sms_aero2/request"
require "sms_aero2/result"
require "sms_aero2/operation"

module SmsAero2
  class Client
    attr_accessor :login, :api_token, :logger

    def initialize(login:, api_token:, logger: Logger.new(STDOUT))
      @login = login
      @api_token = api_token
      @logger = logger
    end

    def send_sms(params)
    end

    def hlr_status(params)
    end

    def hlr(params)
    end
  end
end
