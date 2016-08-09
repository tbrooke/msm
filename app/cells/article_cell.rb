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

  def image
    model['article.main_image']
  end

  def link
    link_to title, link_resolver().link_to(model) 
  end

   # def lede
   #   if model['article.longlede']
   #   model['article.longlede'].as_html_safe(link_resolver())
   #   end
   # end
  
   def content
     model['article.content'].as_html_safe(link_resolver())
   end
end
