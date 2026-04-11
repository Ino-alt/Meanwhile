class EntriesController < ApplicationController
  def create
    moment = current_user.moments.find(params[:moment_id])
    moment.entries.create!(entry_params)
    redirect_to root_path
  end

  private

  def entry_params
    params.require(:entry).permit(:body)
  end
end
