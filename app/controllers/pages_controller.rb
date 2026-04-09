class PagesController < ApplicationController
  def index
    @moment_country = Country.order("RANDOM()").first
    @local_time     = Time.now.in_time_zone(@moment_country.timezone)
  end
end
