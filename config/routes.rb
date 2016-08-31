StarterRubyRails::Application.routes.draw do


  # # Home page
  # GET     /                                           controllers.Application.index(ref: Option[String])
  root 'application#index'

  # # Document detail
  get '/document/:id/:slug', to: 'application#document', constraints: {id: /[-_a-zA-Z0-9]{16}/}, as: :document

  # # Basic search
  get '/search', to: 'application#search', as: :search

  # # Previews
  get '/preview', to: 'application#preview', as: :preview

  # # Community

  get '/community', to: 'application#community', as: :community

  ## Contact
  
  get '/contact', to: 'application#contact', as: :contact

  ## About
  get '/about', to: 'application#about', as: :about

  ## Dignity

  get '/dignity', to: 'application#dignity', as: :dignity

  ## news

  get '/news', to: 'application#news', as: :news

  ## donate

  get '/donate', to: 'application#donate', as: :donate

  ## pledge
  
  get '/pledge', to: 'application#pledge', as: :pledge

  ## helping

  get '/helping', to: 'application#helping', as: :helping

  ## bridge

  get '/bridges', to: 'application#bridges', as: :bridges

  ## need

  get '/need', to: 'application#need', as: :need

  ## mail

  get '/mail', to: 'application#mail', as: :mail

  ## Events

  get '/event', to:'application#event', as: :event

  ## Projects

  get '/project', to:'application#project', as: :project

  ## volunteer

  get '/volunteer', to: 'application#volunteer', as: :volunteer

  ## neighbors

  get '/neighbors', to: 'application#neighbors', as: :neighbors

end
