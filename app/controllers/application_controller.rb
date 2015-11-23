class ApplicationController < ActionController::Base


  include PrismicHelper
  include PrismicController

  protect_from_forgery with: :exception

  # Rescue OAuth errors for some actions
  rescue_from Prismic::Error, with: :clearcookies

  # Homepage action: querying the "everything" form (all the documents, paginated by 20)
  #

  def index
    @features =  api.form("features")
                    .orderings("[my.feature.position]")
                    .submit(ref)
    @sliders   = api.form('slider').submit(ref)
    # @main_1  = PrismicService.get_document(api.bookmark('main_1'), api, ref)
    # @main_2  = PrismicService.get_document(api.bookmark('main_2'), api, ref)
    # @main_3  = PrismicService.get_document(api.bookmark('main_3'), api, ref)
    @main      = api.form('main').submit(ref)
    @google_id = api.experiments.current
    @articles  = api.form("articles")
                     .page(params[:page] ? params[:page] : '1')
                     .page_size(params[:page_size] ? params[:page_size] : '3')
                    .submit(ref)
    @news      = api.form('news')
                    .page(params[:page] ? params[:page] : '1')
                    .page_size(params[:page_size] ? params[:page_size] : '3')
                    .submit(ref)
    @projects  = api.form("projects")
                    .submit(ref)
    @events    = api.form("events")
                    .submit(ref)

  end

  def community
    @document = PrismicService.get_document(api.bookmark("community"), api, ref)
    @google_id = api.experiments.current
    @documents = api.form("everything")
                     .page(params[:page] ? params[:page] : "1")
                     .page_size(params[:page_size] ? params[:page_size] : "20")
                     .submit(ref)
  end

  def neighbors
    @document = PrismicService.get_document(api.bookmark("neighbors"), api, ref)
    @google_id = api.experiments.current
  end

  def bridges
    @document = PrismicService.get_document(api.bookmark("community"), api, ref)
    @google_id = api.experiments.current
  end

  def donate
    @document = PrismicService.get_document(api.bookmark("donate"), api, ref)
    @google_id = api.experiments.current
  end

  def need
    @document = PrismicService.get_document(api.bookmark("need"), api, ref)
    @google_id = api.experiments.current
  end


  def news
    @google_id = api.experiments.current
    @news = api.form("news")
                .submit(ref)
  end

  def event
    @google_id = api.experiments.current
    @events = api.form("events")
                .submit(ref)
  end

  def project
    @google_id = api.experiments.current
    @projects = api.form("projects")
                  .submit(ref)
  end




  def volunteer
    @document = PrismicService.get_document(api.bookmark("volunteer"), api, ref)
    @google_id = api.experiments.current
  end

  def helping
    @document = PrismicService.get_document(api.bookmark("helping"), api, ref)
    @google_id = api.experiments.current
  end


  def about
    @document = PrismicService.get_document(api.bookmark("about"), api, ref)
    @google_id = api.experiments.current
    @documents = api.form("everything")
                     .page(params[:page] ? params[:page] : "1")
                     .page_size(params[:page_size] ? params[:page_size] : "20")
                     .submit(ref)
  end

  # Single-document page action: mostly, setting the @document instance variable, and checking the URL

  def document
    id = params[:id]
    slug = params[:slug]

    @google_id = api.experiments.current
    @document = PrismicService.get_document(id, api, ref)

    # This is how an URL gets checked (with a clean redirect if the slug is one that used to be right, but has changed)
    # Of course, you can change slug_checker in prismic_service.rb, depending on your URL strategy.
    @slug_checker = PrismicService.slug_checker(@document, slug)
    if !@slug_checker[:correct]
      render inline: "Document not found", status: :not_found if !@slug_checker[:redirect]
      redirect_to document_path(id, @document.slug), status: :moved_permanently if @slug_checker[:redirect]
    end
  end

  # Search result: querying all documents containing the q parameter

  def search
    @google_id = api.experiments.current
    @documents = api.form('everything')
                    .query(Prismic::Predicates.fulltext('document', params[:q]))
                    .page(params[:page] ? params[:page] : '1')
                    .page_size(params[:page_size] ? params[:page_size] : '20')
                    .submit(ref)
  end

  # For writers to preview a draft with the real layout

  def preview
    preview_token = params[:token]
    redirect_url = api.preview_session(preview_token, link_resolver(), '/')
    cookies[Prismic::PREVIEW_COOKIE] = { value: preview_token, expires: 30.minutes.from_now }
    redirect_to redirect_url
  end

end
