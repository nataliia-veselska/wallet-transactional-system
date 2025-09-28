# frozen_string_literal: true

class StockPricesController < ApplicationController
  before_action :authenticate_user

  def price_all
    results = LatestStockPrice::PriceAll.get_results

    render json: results
  end

  def prices
    return render json: { error: "Symbols are required" }, status: :bad_request if params[:symbols].blank?

    results = LatestStockPrice::Prices.get_results(params[:symbols])

    render json: results
  end

  def price
    return render json: { error: "Search text is required" }, status: :bad_request if params[:search].blank?

    results = LatestStockPrice::Price.get_results(params[:search])

    render json: results
  end
end
