def get_validation_json(validations)
  result = {}
  validations.each_pair do |qkey, valar|
    result[qkey] = valar.map do |val|
      if val[:type] == :regexp
        valc = val.clone
        valc[:matcher] = "/#{valc[:matcher].source.to_s}/"
        # Replace single backslashes with two backslashes
        valc[:matcher].gsub!("\\", "\\\\")
        valc
      else
        val
      end
    end
  end
  result.to_json
end
