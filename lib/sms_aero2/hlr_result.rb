module SmsAero2
  class HlrResult < Result
    def id
      data.fetch('id')
    end

    def status
      statuses[data.fetch('hlrStatus') - 1]
    end

    private

    def statuses
      [:available, :unavailable, :not_exists, :in_work]
    end
  end
end
