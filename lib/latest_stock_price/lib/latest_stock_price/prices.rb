# frozen_string_literal: true

module LatestStockPrice
  class Prices
    ENDPOINT_NAME = "equities-enhanced"

    def self.get_results(symbols)
      response = Fetcher.new(ENDPOINT_NAME, { "Symbols" => symbols }).response.read_body

      return if response.blank?

      JSON.parse(response)
    end
  end
end
