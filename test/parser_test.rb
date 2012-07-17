require "test_helper"

module HTTPAccept
  describe Parser do
    it "parses a nil field" do
      Parser.new(nil).run.must_equal []
    end

    it "parses an empty field" do
      Parser.new("").run.must_equal []
    end

    it "parses a simple accept header" do
      Parser.new("audio/*").run.map(&:to_s).must_equal [ "audio/*" ]
    end

    it "parses a simple accept header with 'Accept:' still included" do
      Parser.new("Accept: audio/*").run.map(&:to_s).must_equal [ "audio/*" ]
    end

    it "parses an accept header and prefers the most specific type" do
      Parser.new("audio/*; q=0.2, audio/basic").run.map(&:to_s).must_equal [
        "audio/basic",
        "audio/*; q=0.2",
      ]
    end

    it "parses media type parameters containing quotes" do
      Parser.new('audio/*; q="0.2"').run.map(&:to_s).must_equal \
        ["audio/*; q=0.2"]
      Parser.new("audio/*; q='0.2'").run.map(&:to_s).must_equal \
        ["audio/*; q=0.2"]
    end

    it "parses a more elaborate accept header" do
      Parser.new("text/*, text/html, text/html;level=1, */*").
        run.map(&:to_s).must_equal [
          "text/html; level=1",
          "text/html",
          "text/*",
          "*/*",
        ]
    end
  end
end
