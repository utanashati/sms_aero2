require 'logger'
require "sms_aero2/error"
require "sms_aero2/version"
require "sms_aero2/request"
require "sms_aero2/result"
require "sms_aero2/hlr_result"
require "sms_aero2/operation"
require "sms_aero2/hlr_operation"

module SmsAero2
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
      path = options[:testsend] ? 'sms/testsend' : 'sms/send'
      if %w[info digital international direct service].include?(channel)
        SmsAero2::Operation.new(
            request, path,
            number: to, sign: from, text: text, channel: channel.upcase, **options
        ).call
      else
        raise ArgumentError, "invalid channel value, see documentation"
      end
    end

    def hlr_status(id:)
      SmsAero2::HlrOperation.new(request, 'hlr/status',  id: id).call
    end

    def hlr(phone:)
      SmsAero2::HlrOperation.new(request, 'hlr/check', number: phone).call
    end

    private

    def request
      @request ||= SmsAero2::Request.new(self)
    end
  end
end
