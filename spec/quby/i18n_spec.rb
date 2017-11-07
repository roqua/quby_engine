require 'spec_helper'
describe I18n do
  it 'has a translation in every other locale for every key in the nl locale' do
    def to_key_array(hash, current_key = [], current_array = [])
      hash.each do |k, v|
        new_current_key = current_key + [k]
        if v.is_a? Hash
          to_key_array(v, new_current_key, current_array)
        else
          current_array << new_current_key
        end
      end

      current_array
    end

    keys_in_nl_locale = to_key_array I18n.t('.', locale: :nl)
    errors = []
    (I18n.config.available_locales - [:nl]).each do |locale|
      keys_in_nl_locale.each do |deep_key|
        result = begin
          I18n.t('.', locale: locale).dig(*deep_key)
        rescue
          nil
        end
        errors << "#{deep_key.inspect} is missing from locale :#{locale}" if result.blank?
      end
    end

    expect(errors).to eq([])
  end
end
