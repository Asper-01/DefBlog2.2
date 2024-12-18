module ApplicationHelper
  def toggle_direction(column)
    if column == params[:sort] && params[:direction] == "asc"
      "desc"
    else
      "asc"
    end
  end
end
