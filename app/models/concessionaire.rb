class Concessionaire < ApplicationRecord
  include Auditable
  include ImageCompressible

  compress_image :logo

  validates :name, presence: true
end
