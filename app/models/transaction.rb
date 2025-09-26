# frozen_string_literal: true

class Transaction < ActiveRecord::Base
  validates :sum_in_cents, presence: true, numericality: { greater_than: 0 }

  enum status: { success: "success", failed: "failed", pending: "pending" }

  def mark_as_failed
    update(status: "failed")
  end
end
