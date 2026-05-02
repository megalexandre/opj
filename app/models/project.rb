class Project < ApplicationRecord
  include Auditable

  belongs_to :client, class_name: "Customer"
  belongs_to :address, optional: true
end
