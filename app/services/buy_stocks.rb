# frozen_string_literal: true

class BuyStocks < BaseTransaction
  def initialize(source_wallet, stock_symbol, quantity)
    @source_wallet = source_wallet
    @stock_symbol = stock_symbol
    @quantity = quantity.to_i
  end

  attr_reader :source_wallet, :stock_symbol, :quantity, :price
  attr_accessor :sum

  def call
    validate_params
    fetch_stock_data

    @sum = price * quantity
    raise StandardError, "Insufficient balance" if sum > source_wallet.current_balance

    withdrawal = create_withdraw!

    begin
      ActiveRecord::Base.transaction do
        source_wallet.withdraw(sum)
        withdrawal.update!(status: "success")
        source_wallet.walletable.holdings.create!(symbol: stock_symbol, quantity:, price_in_cents: sum * 100)
      end
    rescue StandardError
      if withdrawal.pending?
        withdrawal.mark_as_failed
        raise StandardError, "Couldn't perform the operation"
      end
    end
  end

  private

  def validate_params
    raise StandardError, "Invalid parameters" if stock_symbol.blank? || quantity.blank?
    raise StandardError, "Quantity can't be 0 or less" if quantity <= 0
    raise StandardError, "Wallet not found" unless source_wallet
  end

  def fetch_stock_data
    result = LatestStockPrice::Prices.get_results(stock_symbol)
    stock = result&.find { |e| e["Symbol"] == stock_symbol }
    raise StandardError, "No results" if stock.blank?

    @price = stock["LTP"].to_i
  end
end
