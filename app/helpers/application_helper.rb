module ApplicationHelper
  def fix_url(str)
    str.starts_with?("http://") ? str : "http://#{str}"
  end

  def convert_time(time)
    time.localtime.strftime("%m/%-d/%Y%l:%M%P %Z")
  end

  def display_date_time(dt)
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end

    dt.strftime("%m/%d/%Y %l:%M%P %Z")
  end

  def truncate_string(str, length)
    if str.length > length
      str.slice(0, length)
    end
  end

end
