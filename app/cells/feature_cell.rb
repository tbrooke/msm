class FeatureCell < Cell::ViewModel
   include PrismicHelper
   include PrismicController

  def show
    render
  end

  private


  def title
    model['feature.title'].as_html_safe(link_resolver())
  end

  def lede
    model['feature.longlede'].as_html_safe(link_resolver())
  end
end

