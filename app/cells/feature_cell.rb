class FeatureCell < Cell::ViewModel
   include PrismicHelper
   include PrismicController




   inherit_views EventCell

  def show

    render
  end

  private


  def title
    model['feature.title'].as_html_safe(link_resolver())
  end

  def link
  link_to title, link_resolver().link_to(model) 
  end

  def lede
    if model['feature.longlede']
      model['feature.longlede'].as_html_safe(link_resolver())
    end
  end
end

