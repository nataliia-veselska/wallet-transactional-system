# frozen_string_literal: true

require "uri"
require "net/http"

module LatestStockPrice
  class Fetcher
    URL = "https://latest-stock-price.p.rapidapi.com/"

    def initialize(endpoint, params = nil)
      @endpoint = endpoint
      @params = params
    end

    attr_reader :endpoint, :params

    def response
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      http.request(form_request)
    end

    private

    def form_request
      request = Net::HTTP::Get.new(url)
      request["x-rapidapi-key"] = ENV['RAPID_API_KEY']
      request["x-rapidapi-host"] = "latest-stock-price.p.rapidapi.com"
      request
    end

    def url
      return @url if defined?(@url)

      @url = URI(URL + endpoint)
      @url.query = URI.encode_www_form(params) if params
      @url
    end
  end
end
