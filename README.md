# GrapeDoc

This gem generate API documentation from Grape API.

## Installation

Add this line to your application's Gemfile under development group

    gem 'grape_doc'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grape_doc

## Usage

To generate API documentation you should cd to your app directory

    $ cd app_dir

    # rails
    $ grape_doc

    # non-rails
    $ grape_doc --path sinatra_app.rb # for example


It'll generate documentation for each Grape::API subclass and place it into **grape_doc** directory. Each API subclass were placed as separated file.   

You can pass a doc formatter as parameter

    $ grape_doc

_At this time it supports only MarkDown format._

## Options
  - `-B, --batch` -  Generate documentation for multiple APIs
  - `-b, --bundle` -  Run bundle on child APIs
  - `-o, --output-dir` -  Directory to save documentation file(s) (default: /current/directory/grape_doc)
  - `-F, --resource-files` -  API resource files, relative to project root (default: ./config/environment.rb)
  - `-r, --root-api` -  Top level API class name
  - `-s, --stdout` -  Print documentation stdout instead of generating files
  - `-h, --help` -  Show this message

#### example usage:
`grape_doc -sB --resource-files ./config/environment.rb ./app.rb --root-api App::API`

The above will require config/environment.rb, app.rb, and print all API classes mounted under App::API to stdout.

## API description

### Parameters

#### grape > 0.2.1

    desc "Returns a tweet."
    params do
      requires :id, 
               :type => Integer, 
               :desc => "Tweet id."
    end
    get '/show/:id' do
      Tweet.find(params[:id])
    end

#### grape <= 0.2.1

    desc "Returns a tweet.",
    :params => {
      :id => {
        :desc => "Tweet id.",
        :type => Integer,
        :requires => true
      }
    }
    get '/show/:id' do
      Tweet.find(params[:id])
    end

## TODO

 - generate plain response
 - generate response from Grape::Entity
 - generate response from Grape::Entity with nested entities
 - other output formats
 - ~~write docs into separated files~~
 - add code documentation
 - and more others features

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
