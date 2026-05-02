class UploadSerializer
  def initialize(upload)
    @upload = upload
  end

  def as_json(*)
    {
      id:         @upload.id,
      item_id:    @upload.item_id,
      filename:   @upload.filename,
      url_s3:     @upload.s3_url,
      size:       @upload.size,
      created_at: @upload.created_at,
      updated_at: @upload.updated_at
    }
  end
end
