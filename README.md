# Pagination

[![Code Climate](https://codeclimate.com/github/sumskyi/padrino-pagination.png)](https://codeclimate.com/github/sumskyi/padrino-pagination)

Pagination for Padrino framework:

* brutal
* classic
* digg
* extended
* bootstrap_classic
* punbb (default)

## Installation

Add this line to your application's Gemfile:

    gem 'padrino-pagination'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install padrino-pagination

## Usage

Register pagination helper in your application:

    register Padrino::Helpers::Pagination

In your template:

    = paginate(:posts, :index, 7890, :page => 1)

or with options:

    = paginate(:articles, :list, total, :page => page, :per_page => 12, :template => :brutal)

### Options

The helper uses the link style of `url(:controller, :action, :current_page => page)` so that way it can be flexible for your controller schema.
```
╔══════════════╦════════════════════════════════╗
║ page         ║ current page (default 1)       ║
╠══════════════╬════════════════════════════════╣
║ per_page     ║ items per page (default 20)    ║
╠══════════════╬════════════════════════════════╣
║ template     ║ used template (see list above) ║
╚══════════════╩════════════════════════════════╝

```

## HTML / CSS API
* The pages are enclosed by a div with “pagination” class
* Prevev/next links has “prev_next” class
* First/last links has “first_last” class
* The numbers are enclosed by a div with “pages” clas
* Page links are, well, links inside that “pages” div
* And the current page is a span with “current” class


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

* [Padrino]
* [Sinatra]
* templates are based on [Kohanaphp 2.3.4] pagination templates

Copyright (c) 2010-2013 Vladyslav Sumskyi, released under the WTFPL license

  [Padrino]: http://www.padrinorb.com/
  [Sinatra]: http://www.sinatrarb.com/
  [Kohanaphp 2.3.4]: http://kohanaframework.org/download
  
