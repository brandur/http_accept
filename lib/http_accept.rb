require "http_accept/media_type"
require "http_accept/parser"

module HTTPAccept
  extend self

  def parse(content)
    Parser.new(content).run
  end
end
