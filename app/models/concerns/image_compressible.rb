module ImageCompressible
  extend ActiveSupport::Concern

  MAX_DIMENSION = 200
  QUALITY = 80

  class_methods do
    def compress_image(field)
      before_save -> { compress_base64_image(field) },
        if: -> { send(:"#{field}_changed?") && send(field).present? }
    end
  end

  private

  def compress_base64_image(field)
    header, data = send(field).split(",", 2)
    return unless data

    mime = header[/data:(image\/\w+);/, 1] || "image/png"
    ext  = mime.split("/").last

    image = MiniMagick::Image.read(Base64.decode64(data), ".#{ext}")
    image.resize "#{MAX_DIMENSION}x#{MAX_DIMENSION}>"
    image.quality QUALITY.to_s

    send(:"#{field}=", "data:#{mime};base64,#{Base64.strict_encode64(image.to_blob)}")
  end
end
