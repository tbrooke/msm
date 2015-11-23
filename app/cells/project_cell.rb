class ProjectCell < Cell::ViewModel

  include PrismicHelper
  include PrismicController

  def show
    render
  end


    private

    def title
      model['project.title'].as_html_safe(link_resolver())
    end

    def image
      model['project.main_image']
    end

    def link
      link_to title, link_resolver().link_to(model)
    end

    def lede
      if model['project.longlede']
        model['project.longlede'].as_html_safe(link_resolver())
      end
    end
 end
