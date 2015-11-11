class DocumentCell < Cell::ViewModel
  def show
    render
  end

  private

  def title
    model['document.title'].as_html_safe(link_resolver())
  end

  def image
    model['document.main_image']
  end

  def link
    link_to title, link_resolver().link_to(model)
  end

  def lede
    if model['document.longlede']
      model['document.longlede'].as_html_safe(link_resolver())
    end

    def content
      if model['document.content']
        model['document.content'].as_html_safe(link_resolver())

      end

    end
  end
end

