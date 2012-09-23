module HashExtension
  def convert_keys
    result = {}
    self.each do |k, v|
      converted = yield k
      result[converted] = v
    end
    return result
  end
end