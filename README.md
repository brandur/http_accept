http_accept
===========

Simple library for HTTP Accept header parsing and ordering.

``` ruby
HTTPAccept::Parser.new("text/*, text/html, text/html;level=1, */*").run.map(&:to_s)
=> ["text/html; level=1", "text/html", "text/*", "*/*"]
```

Testing
-------

    rake test
