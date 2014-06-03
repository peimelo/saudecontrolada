module NavigationHelper
  def currently_at(tab)
    render partial: 'layouts/main_nav', locals: {current_tab: tab}
  end

  # retornar :class "active" ou "inactive" dependendo do valor passado por parâmetro
  def nav_tab(title, url, options = {})
    current_tab = options.delete(:current)
    titulo = options.delete(:titulo) if !options[:titulo].nil?
    titulo ||= title

    options[:class] = (current_tab == titulo) ? 'active' : 'inactive'
    # é colocado o id do link para ser usado nas features do RSpec
    content_tag(:li, link_to(title, url, id: url), options)
  end
end