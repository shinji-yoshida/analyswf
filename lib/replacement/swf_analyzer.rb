module Replacement
  class SwfAnalyzer
    def self.analyze_swf(file)
      analyze_dump(`swf_dump #{file}`)
    end

    def self.analyze_dump(dump_text)
      jpeg_offsets = collect_jpeg_offsets(dump_text)
      gif_offsets = collect_gif_offsets(dump_text)
      result = SwfAnalyzer.new(jpeg_offsets: jpeg_offsets, gif_offsets: gif_offsets)
      return result
    end

    def jpeg_offsets
      @jpeg_offsets.dup
    end

    def gif_offsets
      @gif_offsets.dup
    end

    protected

    def initialize(map)
      @jpeg_offsets = map[:jpeg_offsets] || {}
      @gif_offsets = map[:gif_offsets] || {}
    end

    def self.collect_jpeg_offsets(dump_text)
      return collect_offsets(dump_text, 'DefineBitsJPEG2')
    end

    def self.collect_gif_offsets(dump_text)
      return collect_offsets(dump_text, 'DefineBitsLossless2')
    end

    def self.collect_offsets(dump_text, tag)
      offsets = []
      dump_text.split(/\n/).each do |line|
        if /^#{tag}.*/ =~ line
          / offset: (\d+)/ =~line
          offsets.push Regexp.last_match(1).to_i
        end
      end
      return offsets
    end

  end
end