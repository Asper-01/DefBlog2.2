class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home

  end

  def legal

  end

  def sitemap

  end

  def contact

  end
end
