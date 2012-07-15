module HTTPAccept
  class Parser
    def initialize(content)
      @content = content
    end

    def run
      content = @content.gsub(/\AAccept:\s*/, '')
      content.split(',').map { |s| s.strip }.map do |segment|
        format, params = parse_params(segment)
        MediaType.new(:format => format, :params => params)
      end.sort
    end

    private

    def parse_params(segment)
      format, *params = segment.split(";")
      params = Hash[*params.map { |p| p.scan(/(\w)+=([\w.]+)/) }.flatten]
      return [format, params]
    end
  end
end
