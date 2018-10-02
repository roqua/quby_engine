# frozen_string_literal: true

require 'spec_helper'
describe I18n do
  it 'has a translation in every other locale for every key in the nl locale' do
    errors = []
    (I18n.config.available_locales - [:nl]).each do |locale|
      each_key_path(I18n.t('.', locale: :nl)) do |key_path|
        result = begin
          I18n.t('.', locale: locale).dig(*key_path)
        rescue
          nil
        end
        errors << "#{key_path.inspect} is missing from locale :#{locale}" if result.nil?
      end
    end

    expect(errors).to eq([])
  end

  # yields for each leaf key `[:path, :to, :leaf]`
  def each_key_path(hash, base_key = [], &block)
    hash.each do |k, v|
      current_key = base_key + [k]
      if v.is_a? Hash
        each_key_path(v, current_key, &block)
      else
        yield current_key
      end
    end
  end
end
