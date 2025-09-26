# frozen_string_literal: true

class Holding < ActiveRecord::Base
  belongs_to :user

  validates :symbol, :price_in_cents, :quantity, presence: true
  validates :symbol, uniqueness: true
  validates :quantity, numericality: { greater_than: 0 }
end
