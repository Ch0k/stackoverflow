class BadgesController < ApplicationController
  before_action :authenticate_user!

  authorize_resource

  def index
    @badges = Badge.all
  end
end
