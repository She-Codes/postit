module ApplicationHelper
  def fix_url(str)
    str.starts_with?("http://") ? str : "http://#{str}"
  end

  def convert_time(time)
    time.localtime.strftime("%m/%-d/%Y%l:%M%P %Z")
  end

  def find_comment_post_title(comment)
    post_id = comment.post_id
    post = Post.find(post_id)
    post_title = post.title
  end
end
