class MainCell < Cell::ViewModel


  include PrismicHelper
  include PrismicController

  def show
    render
  end


  private

  def title
    model['main.title'].as_html_safe(link_resolver())
  end

  def image
    if model['main.illustration']
      model['main.illustration'].as_html_safe(link_resolver())
    end
  end

  def text
    if model['main.text']
      model['main.text'].as_html_safe(link_resolver())
    end
  end

  def content
    if model['main.content']
      model['main.content'].as_html_safe(link_resolver())
    end
    
  end

  def link
    if model['main.reference']
       model['main.reference'].url(link_resolver())
    end
  end

end
