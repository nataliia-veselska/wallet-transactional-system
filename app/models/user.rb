# frozen_string_literal: true

class User < ActiveRecord::Base
  has_one :wallet
  has_many :holdings

  has_secure_password

  validates :full_name, :email, presence: true
end
