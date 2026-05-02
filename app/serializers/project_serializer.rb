class ProjectSerializer
  def initialize(project)
    @project = project
  end

  def as_json(*)
    {
      id: @project.id,
      client_id: @project.client_id,
      address_id: @project.address_id,
      utility_company: @project.utility_company,
      utility_protocol: @project.utility_protocol,
      customer_class: @project.customer_class,
      integrator: @project.integrator,
      modality: @project.modality,
      framework: @project.framework,
      status: @project.status,
      amount: @project.amount,
      dc_protection: @project.dc_protection,
      system_power: @project.system_power,
      unit_control: @project.unit_control,
      description: @project.description,
      project_type: @project.project_type,
      fast_track: @project.fast_track,
      coordinates: serialize_coordinates(@project.coordinates),
      services_names: @project.services_names,
      created_at: @project.created_at,
      updated_at: @project.updated_at,
      created_by: @project.created_by,
      updated_by: @project.updated_by
    }
  end

  private

  def serialize_coordinates(point)
    return nil if point.nil?

    { latitude: point.y, longitude: point.x }
  end
end
