require 'logger'
require "sms_aero/error"
require "sms_aero/version"
require "sms_aero/request"
require "sms_aero/result"
require "sms_aero/hlr_result"
require "sms_aero/operation"
require "sms_aero/hlr_operation"

module SmsAero
  class Client
    attr_accessor :login, :api_token, :logger

    def initialize(login:, api_token:, logger: nil)
      @login = login
      @api_token = api_token
      @logger = logger
    end

    # channel values:
    # 'info'	Info signature for all operators
    # 'digital'	Digital channel sending (only permitted transaction flow)
    # 'international'	International delivery (Operators of Russia, Kazakhstan, Ukraine and Belarus)
    # 'direct'	Advertising channel send message free letter signature.
    # 'service' Service channel for sending service SMS according to the approved template
    # with a paid signature of the sender.
    def send_sms(to:, from:, text:, channel:, **options)
      if %w[info digital international direct service].include?(channel)
        SmsAero::Operation.new(
            request, 'sms/send',
            number: to, sign: from, text: text, channel: channel.upcase, **options
        ).call
      else
        raise ArgumentError, "invalid channel value, see documentation"
      end
    end

    def hlr_status(id:)
      SmsAero::HlrOperation.new(request, 'hlr/status', id: id).call
    end

    def hlr(phone:)
      SmsAero::HlrOperation.new(request, 'hlr/check', number: phone).call
    end

    private

    def request
      @request ||= SmsAero::Request.new(self)
    end
  end
end
