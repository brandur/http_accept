require "test_helper"

module HTTPAccept
  describe MediaType do
    describe "#<=>" do
      it "detects when two media types are equal" do
        MediaType.new(:format => "application/json").
          must_equal MediaType.new(:format => "application/json")
        MediaType.new(:format => "application/json",
          :params => { "level" => 2 }).
          must_equal MediaType.new(:format => "application/json",
            :params => { "level" => 2 })
      end

      it "detects when a media type is more specific than another" do
        MediaType.new(:format => "application/*").must_be :<,
          MediaType.new(:format => "text/plain", :params => { "q" => "0.8" })
        MediaType.new(:format => "application/json",
          :params => { "level" => 2 }).must_be :<,
          MediaType.new(:format => "application/*")
        MediaType.new(:format => "application/json").must_be :<,
          MediaType.new(:format => "application/*")
        MediaType.new(:format => "application/*").must_be :<,
          MediaType.new(:format => "*/*")
      end

      it "detects when a media type is less specific than another" do
        MediaType.new(:format => "text/plain", :params => { "q" => "0.8" }).must_be :>,
          MediaType.new(:format => "application/*")
        MediaType.new(:format => "application/*").must_be :>,
          MediaType.new(:format => "application/json",
            :params => { "level" => 2 })
        MediaType.new(:format => "application/*").must_be :>,
          MediaType.new(:format => "application/json")
        MediaType.new(:format => "*/*").must_be :>,
          MediaType.new(:format => "application/*")
      end
    end

    describe "#all_subtypes?" do
      it "recognizes when a format contains all subtypes" do
        MediaType.new(:format => "application/json").all_subtypes?.must_equal false
        MediaType.new(:format => "application/*").all_subtypes?.must_equal true
        MediaType.new(:format => "*/*").all_subtypes?.must_equal true
      end
    end

    describe "#all_types?" do
      it "recognizes when a format contains all types" do
        MediaType.new(:format => "application/json").all_types?.must_equal false
        MediaType.new(:format => "application/*").all_types?.must_equal false
        MediaType.new(:format => "*/*").all_types?.must_equal true
      end
    end

    describe "#to_h" do
      it "converts a parsed media type back to a hash" do
        MediaType.new(:format => "application/json").
          to_h.must_equal({ :format => "application/json", :params => {} })
        MediaType.new(:format => "application/json", 
          :params => { "level" => "2" }).
          to_h.must_equal({ :format => "application/json",
            :params => { "level" => "2" } })
      end
    end

    describe "#to_s" do
      it "converts a parsed media type back to a string" do
        MediaType.new(:format => "application/json").
          to_s.must_equal "application/json"
        MediaType.new(:format => "application/json", 
          :params => { "level" => "2" }).
          to_s.must_equal "application/json; level=2"
      end
    end
  end
end
