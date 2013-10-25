#
# Provides color palatte for creating choropleth maps
#

module Colors

  def colorize(color)
    case color
    when "green"
      return %w(#EDF8E9 #C7E9C0 #A1D99B #74C476 #31A354 #006D2C)
    when "purple"
      return %w(#F2F0F7 #DADAEB #BCBDDC #9E9AC8 #756BB1 #54278F)
    when "grey"
      return %w(#F7F7F7 #D9D9D9 #BDBDBD #969696 #636363 #252525)
    when "blue"
      return %w(#EFF3FF #C6DBEF #9ECAE1 #6BAED6 #3182BD #08519C)
    when "red"
      return %w(#FEE5D9 #FCBBA1 #FC9272 #FB6A4A #DE2D26 #A50F15)
    end
  end

end

