class DocumentController < ActionController::Base
  include PrismicHelper
  include PrismicController

  def feature
    @feature =  PrismicService.get_document(api.bookmark("feature"), api, ref)
  end

end