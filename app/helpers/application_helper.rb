module ApplicationHelper
  
  def full_title(page_title = '')
    base_title = 'Answeres'
    if page_title.present?
      "#{page_title} | #{base_title}"
    else
      base_title
    end
  end

  def currently_at(current_page)
    render partial: 'shared/menu', locals: {current_page: current_page}
  end

  def nav_tab(title, url, options = {})
    current_page = options[:current_page]
    class_css = current_page == title ? 'active' : ''
    options[:class] = if options[:class]
                        options[:class] + ' ' + class_css
                      else
                        class_css 
                      end
    link_to title, url, options
  end

end
