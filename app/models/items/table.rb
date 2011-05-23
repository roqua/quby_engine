class Items::Table < Item
  
  attr_accessor :columns
  attr_accessor :items
  
  # Whether the question options in this table should show their descriptions
  attr_accessor :show_option_desc
  
  def initialize(options = {})
    @columns = options[:columns]
    @show_option_desc = options[:show_option_desc] || false
    @items = []
  end
  
  def item_table
    rows
    @item_table    
  end
  
  #TODO: cleanup to map/functional style 
  def rows
    return @rows if @rows
    @item_table = [[]]
    @rows = [[[]]]
    filled_columns = 0
    filled_rows = 0
    row_items = 0
    items.each do |item|
      if item.class.name == "Items::Text" or not ([:check_box, :radio, :scale].include? item.type) 
        @item_table[filled_rows] << item
        @rows[filled_rows][row_items] << item
        filled_columns += item.col_span
        if filled_columns >= columns and item != items.last 
          filled_rows += 1
          filled_columns = 0
          row_items = 0
          @rows << [[]]
          @item_table << []
        end
        if filled_columns != 0 and item != items.last
          row_items += 1
          @rows[filled_rows] << []
        end
      else #is :check_box, :radio or :scale question
        @item_table[filled_rows] << item
        if item.options.length <= columns #multiple questions on one row
          item.options.each do |opt|
            @rows[filled_rows][row_items] << opt            
            filled_columns += 1
            if filled_columns >= columns and item != items.last 
              filled_rows += 1
              filled_columns = 0
              row_items = 0
              @rows << [[]]
              @item_table << []
            end
          end
          if filled_columns != 0 and item != items.last
            row_items += 1
            @rows[filled_rows] << []            
          end
        else #one question's options split over multiple rows, ordered row wise
          opt_len = item.options.length
          col_len = (opt_len / columns.to_f).ceil
          (0...col_len).each do |j|
            (0...columns).each do |i|
              break if j + i*col_len >= opt_len
              @rows[filled_rows][row_items] << item.options[j + i*col_len]
              filled_columns += 1
              if filled_columns == columns
                filled_rows += 1
                filled_columns = 0
                @rows << [[]]
                @item_table << [item]
              end
            end
          end
        end
      end
    end
    @rows
  end
  
  def type
    "table"
  end
  
end