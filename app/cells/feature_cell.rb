class FeatureCell < Cell::ViewModel
  include PrismicHelper
  include PrismicController

  def show
    render
  end


  private

  def body

    self = PrismicService.get_document(api.bookmark("feature"), api, ref)

  end

end

