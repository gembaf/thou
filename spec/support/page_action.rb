module PageAction
  def reload
    visit page.current_url
  end
end

