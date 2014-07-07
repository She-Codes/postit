module ApplicationHelper
  def fix_url(str)
    str.starts_with?("http://") ? str : "http://#{str}"
  end

  def convert_time(time)
    time.localtime.strftime("%m/%-d/%Y%l:%M%P %Z")
  end
end
