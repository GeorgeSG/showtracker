module ShowsHelper
  def show_status_css_class(status)
    case status
    when 'Continuing' then 'text-success'
    when 'Ended'      then 'text-danger'
    end
  end
end
