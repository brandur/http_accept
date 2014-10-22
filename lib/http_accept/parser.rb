module HTTPAccept
  class Parser
    def initialize(content)
      @content = content
    end

    def run
      return [] unless @content
      content = @content.gsub(/\AAccept:\s*/, '')
      content.split(',').map { |s| s.strip }.map do |segment|
        next nil if segment.empty?
        format, params = parse_params(segment)
        MediaType.new(:format => format, :params => params)
      end.compact.sort
    end

    private

    PARAM_PATTERN = /((\w+)\s*=\s*'([\w.\-_]+)'|(\w+)\s*=\s*"?([\w.\-_]+)"?)/

    def parse_params(segment)
      format, *params = segment.split(";")
      arr = params.map { |p| p.scan(PARAM_PATTERN).map { |a| a.drop(1) } }.
        flatten.compact
      params = Hash[*arr]
      return [format, params]
    end
  end
end
