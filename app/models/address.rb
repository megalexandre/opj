class Address < ApplicationRecord
  has_one :customer, dependent: :restrict_with_error
end
