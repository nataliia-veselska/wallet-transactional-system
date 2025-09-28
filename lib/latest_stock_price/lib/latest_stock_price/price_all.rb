# frozen_string_literal: true

module LatestStockPrice
  class PriceAll
    ENDPOINT_NAME = "any"

    def self.get_results
      response = Fetcher.new(ENDPOINT_NAME).response.read_body

      return if response.blank?

      JSON.parse(response)
    end
  end
end
