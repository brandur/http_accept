module HTTPAccept
  class MediaType
    include Comparable

    attr_accessor :format, :params

    def initialize(args = {})
      self.format = args[:format]
      self.params = args[:params] || {}
    end

    def <=>(other)
      # return -1 if more specific than other, so we end up at the front of the
      # array
      if q > other.q
        -1
      elsif q < other.q 
        1
      elsif !all_subtypes? && other.all_subtypes? ||
        !all_types? && other.all_types?
        -1
      elsif all_subtypes? && !other.all_subtypes? ||
        all_types? && !other.all_types?
        1
      elsif params.count == other.params.count
        0
      elsif params.count > other.params.count
        -1
      else
        1
      end
    end

    def all_subtypes?
      format.match(/\/\*\Z/) != nil
    end

    def all_types?
      format == "*/*"
    end

    def q
      params["q"] ? params["q"].to_f : 1.0
    end

    def to_h
      { :format => format, :params => params }
    end

    def to_s
      if params.count > 0
        format + "; " + params.map { |k, v| "#{k}=#{v}" }.join("; ")
      else
        format
      end
    end
  end
end
