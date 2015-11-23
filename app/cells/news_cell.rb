class NewsCell < Cell::ViewModel

  include PrismicHelper
  include PrismicController

  def show
    render
  end

  private

  def title
    model['news.title'].as_html_safe(link_resolver())
  end

  def image
    model['news.image']
  end

  def link
    link_to title, link_resolver().link_to(model)
  end

  def lede
    if model['news.longlede']
      model['news.longlede'].as_html_safe(link_resolver())
    end
  end

end
