class Project < ApplicationRecord
  belongs_to :client, class_name: "Customer"
  belongs_to :address, optional: true
end
