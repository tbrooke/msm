class ArticleCell < Cell::ViewModel
   include PrismicHelper
   include PrismicController

  def show
    render
  end

  private

  def title
    model['article.title'].as_html_safe(link_resolver())
  end

  def link
  link_to title, link_resolver().link_to(model) 
  end

  def lede
    model['article.longlede'].as_html_safe(link_resolver())
  end
end
