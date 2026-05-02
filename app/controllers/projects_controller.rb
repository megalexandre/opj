class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show update destroy ]

  # GET /projects
  def index
    @projects = Project.all

    render json: @projects.map { |p| ProjectSerializer.new(p).as_json }
  end

  # GET /projects/1
  def show
    render json: ProjectSerializer.new(@project).as_json
  end

  # POST /projects
  def create
    @project = Project.new(project_params)

    if @project.save
      render json: ProjectSerializer.new(@project).as_json, status: :created, location: @project
    else
      render json: @project.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      render json: ProjectSerializer.new(@project).as_json
    else
      render json: @project.errors, status: :unprocessable_content
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.permit(:client_id, :address_id, :utility_company, :utility_protocol, :customer_class, :integrator, :modality, :framework, :status, :amount, :dc_protection, :system_power, :unit_control, :description, :project_type, :fast_track, :coordinates, services_names: [])
    end
end
