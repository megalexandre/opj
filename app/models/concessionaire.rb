class Concessionaire < ApplicationRecord
  include Auditable
  include ImageCompressible

  compress_image :logo
end
