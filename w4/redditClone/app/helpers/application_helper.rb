module ApplicationHelper
  def csrf_tag
    res = <<-HTML.gsub(/\s+/, ' ').html_safe
      <input
        type='hidden'
        name='authenticity_token'
        value='#{form_authenticity_token}'>
    HTML
  end

  def patch_tag
    "<input type='hidden' name='_method' value='patch'>".html_safe
  end
end
