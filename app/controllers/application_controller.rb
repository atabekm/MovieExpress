class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def send_post(text)
    if current_user
      user = current_user.email
    else
      user = 'Anonymous'
    end
    data = {'client' => 'Web', 'event_name' => "[#{user}]#{text}"}

    Net::HTTP.post_form(URI.parse($url), data)
  end
end
