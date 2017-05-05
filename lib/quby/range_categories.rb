class RangeCategories
  def initialize(*range_categories)
    if range_categories.length.even? || range_categories.length < 3
      fail "RangeCategories should be of the form (0, 'label 0-10', 10, 'label 10-20', 20)"
    end

    @range_hash = {}
    parse_ranges(range_categories)
  end

  def as_range_hash
    @range_hash.freeze
  end

  private

  def parse_ranges(range_categories)
    a = range_categories.dup
    while a.length > 1
      from = a.shift.to_f
      label = a.shift
      to = a.first.to_f
      add_range(from, label, to, inclusive: a.length == 1)
    end
  end

  def add_range(from, label, to, inclusive:)
    if inclusive
      @range_hash[from..to] = label
    else
      @range_hash[from...to] = label
    end
  end
end
