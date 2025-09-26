# frozen_string_literal: true

class Wallet < ActiveRecord::Base
  belongs_to :user
  has_many :deposits
  has_many :withdrawals
end
