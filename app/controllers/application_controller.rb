class ApplicationController < ActionController::Base
  include PrismicHelper
  include PrismicController

  protect_from_forgery with: :exception

  # Rescue OAuth errors for some actions
  rescue_from Prismic::Error, with: :clearcookies

  # Homepage action: querying the "everything" form (all the documents, paginated by 20)
  def index
    @document = PrismicService.get_document(api.bookmark("heading"), api, ref)
    @features =  api.form("features")
                    .orderings("[my.feature.position]")
                    .submit(ref)
    @articles = api.form("articles")
                    .query(%([[:d = at(document.tags, ["homepage"])]]))
                    .orderings("[my.article.position]")
                    .submit(ref)
    @google_id = api.experiments.current
    @documents = api.form("everything")
                    .page(params[:page] ? params[:page] : "1")
                    .page_size(params[:page_size] ? params[:page_size] : "20")
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

  def donate
    @document = PrismicService.get_document(api.bookmark("donate"), api, ref)
    @google_id = api.experiments.current
    @documents = api.form("everything")
                     .page(params[:page] ? params[:page] : "1")
                     .page_size(params[:page_size] ? params[:page_size] : "20")
                     .submit(ref)
  end

  def need
    @document = PrismicService.get_document(api.bookmark("need"), api, ref)
    @google_id = api.experiments.current
    @documents = api.form("everything")
                     .page(params[:page] ? params[:page] : "1")
                     .page_size(params[:page_size] ? params[:page_size] : "20")
                     .submit(ref)
  end

  def news
    @document = PrismicService.get_document(api.bookmark("news"), api, ref)
    @google_id = api.experiments.current
    @documents = api.form("everything")
                     .page(params[:page] ? params[:page] : "1")
                     .page_size(params[:page_size] ? params[:page_size] : "20")
                     .submit(ref)
  end

  def volunteer
    @document = PrismicService.get_document(api.bookmark("volunteer"), api, ref)
    @google_id = api.experiments.current
    @documents = api.form("everything")
                     .page(params[:page] ? params[:page] : "1")
                     .page_size(params[:page_size] ? params[:page_size] : "20")
                     .submit(ref)
  end

  def helping
    @document = PrismicService.get_document(api.bookmark("helping"), api, ref)
    @google_id = api.experiments.current
    @documents = api.form("everything")
                     .page(params[:page] ? params[:page] : "1")
                     .page_size(params[:page_size] ? params[:page_size] : "20")
                     .submit(ref)
  end

  def contact
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
