class ProjectCreate
  def initialize(params:, current_user:)
    @params = params
    @current_user = current_user
  end

  def call
    ActiveRecord::Base.transaction do
      project = Project.new(@params)
      project.sequence = next_sequence unless project.sequence
      project.created_by = @current_user.id
      project.updated_by = @current_user.id
      project.save!

      if @params[:status].present?
        project.statuses.create!(
          name: @params[:status],
          created_by: @current_user.id
        )
      end

      project
    end
  end

  private

  def next_sequence
    (Project.maximum(:sequence) || 0) + 1
  end
end
