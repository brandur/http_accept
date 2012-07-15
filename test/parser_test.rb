require "test_helper"

module HTTPAccept
  describe Parser do
    it "parses a simple accept header" do
      Parser.new("audio/*").run.map(&:to_h).must_equal [
        { :format => "audio/*", :params => {} }
      ]
    end

    it "parses a simple accept header with 'Accept:' still included" do
      Parser.new("Accept: audio/*").run.map(&:to_h).must_equal [
        { :format => "audio/*", :params => {} }
      ]
    end

    it "parses an accept header and prefers the most specific type" do
      Parser.new("audio/*; q=0.2, audio/basic").run.map(&:to_h).must_equal [
        { :format => "audio/basic", :params => {} },
        { :format => "audio/*", :params => { "q" => "0.2" } },
      ]
    end
  end
end
