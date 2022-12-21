class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    @count = @project.contestant_count
  end

  def update
    new_contestant = Contestant.find(params[:contestant_id])
    new_project = Project.find(params[:id])
    contestant_project = ContestantProject.create!(contestant: new_contestant, project: new_project)

    redirect_to "/projects/#{new_project.id}"
  end
end