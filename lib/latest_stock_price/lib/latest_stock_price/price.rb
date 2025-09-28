# frozen_string_literal: true

module LatestStockPrice
  class Price
    ENDPOINT_NAME = "equities-search"

    def self.get_results(search)
      response = Fetcher.new(ENDPOINT_NAME, { "Search" => search }).response.read_body

      return if response.blank?

      JSON.parse(response)
    end
  end
end
