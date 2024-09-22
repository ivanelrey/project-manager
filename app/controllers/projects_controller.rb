# frozen_string_literal: true

class ProjectsController < ApplicationController
  def index
    @projects = Project.order(created_at: :desc)
  end

  def show
    @project = Project.find(params[:id])
    @comments = @project.comments.order(created_at: :desc)
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
    @available_statuses = Project::STATUSES
  end

  def create
    Projects::Create::Service.new({}).call
    redirect_to projects_path, flash: { success: 'Project created successfully!' }
  rescue ActiveModel::ValidationError
    flash.now[:error] = 'Failed to create project.'
    render :new
  end

  def update
    @project = Projects::Update::Service.new(params[:id], update_project_params).call
    redirect_to project_path(project), flash: { success: 'Project updated successfully!' }
  rescue ActiveModel::ValidationError
    flash.now[:error] = 'Failed to update project.'
    render :edit
  end

  private

  def create_project_params
    params.require(:project).permit(:name, :description)
  end

  def update_project_params
    params.require(:project).permit(:status)
  end
end
