# -*- encoding: utf-8 -*-
module Domain
  module Swf
    def self.create_in_transaction(swf_series, swf_data)
      swf_series.with_lock do
        return create!(swf_series, swf_data)
      end
    end

    def self.create!(swf_series, swf_data)
      swf = swf_series.swfs.create!
      swf.extend(Domain::Swf)
      swf.setup!(swf_data)

      return swf
    end

    def setup!(swf_data)
      setup_offsets!(swf_data)
      set_myself_as_latest_version
      create_swf_binary!(data: swf_data)
    end

    private

    def setup_offsets!(swf_data)
      analyzed = analyze_swf(swf_data)
      analyzed.jpeg_offsets.each do |o|
        offsets.create!(offset_type: TargetType::JPEG, value: o)
      end
      analyzed.gif_offsets.each do |o|
        offsets.create!(offset_type: TargetType::GIF, value: o)
      end
    end

    def analyze_swf(data)
      do_analyze_swf(data)
    rescue => e
      delete_tmp_swf_file
      raise ApplicationException.new "例外: #{e.message}"
    end

    def do_analyze_swf(data)
      File.binwrite(tmp_swf_file, data)
      result = Replacement::SwfAnalyzer.analyze_swf(tmp_swf_file)
      delete_tmp_swf_file
      return result
    end

    def tmp_swf_file
      tmp_swf_file = File.join(tmp_swf_dir, 'tmp.swf')
    end

    def tmp_swf_dir
      result = Rails.root.join('tmp', 'swf')
      FileUtils.mkdir_p result
      return result
    end

    def delete_tmp_swf_file
      File.delete(tmp_swf_file)
    end

    def set_myself_as_latest_version
      swf_title = swf_series.swf_title
      self.version = previous_latest_version(swf_title) + 1
      save!
      swf_title.latest_swf = self
      swf_title.save!
    end

    def previous_latest_version(swf_title)
      if swf_title.latest_swf.present?
        return swf_title.latest_swf.version
      else
        return 0
      end
    end
  end
end