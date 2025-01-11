class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home

  end

  def legal

  end

  def sitemap

  end

  def contact

  end
end
