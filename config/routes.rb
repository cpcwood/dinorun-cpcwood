# frozen_string_literal: true

Rails.application.routes.draw do
  # Route to onepage app
  root 'homepage#index'

  # Error pages
  get '404', to: 'error#show', via: :all
  get '422', to: 'error#show', via: :all
  get '500', to: 'error#show', via: :all

  # JSON only for single page app
  post 'user', to: 'user#create', constraints: ->(req) { req.format == :json }

  get 'session', to: 'session#index', constraints: ->(req) { req.format == :json }
  post 'session', to: 'session#create', constraints: ->(req) { req.format == :json }
  delete 'session', to: 'session#destroy', constraints: ->(req) { req.format == :json }

  get 'songs', to: 'songs#index', constraints: ->(req) { req.format == :json }
  get 'songs/:id', to: 'songs#show', constraints: ->(req) { req.format == :json }
  post 'songs', to: 'songs#create'

  post 'scores', to: 'scores#create', constraints: ->(req) { req.format == :json }
  get 'scores/:id', to: 'scores#show', constraints: ->(req) { req.format == :json }

  # Testing/Development
  get 'jasmine', to: 'jasmine#index' if Rails.env.development? || Rails.env.test?
end
