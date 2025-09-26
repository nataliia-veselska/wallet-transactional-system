# frozen_string_literal: true

class User < ActiveRecord::Base
  has_one :wallet
  has_many :holdings, dependent: :destroy

  has_secure_password

  validates :full_name, :email, :login, presence: true
  validates :email, :login, uniqueness: true
end
