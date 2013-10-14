#
# geojson:   formats and draws GeoJSON objects.
# geochloro: only draws chlropleth maps. formatting is in chloro.rb
#

class GeoJSON

  def geojson (source, style={})
    template  = File.read(File.dirname(__FILE__) + '/templates/geojson.js')
    options   = {    
      :weight       => 1.5,
      :color        => '#999',
      :opacity      => 1,
      :fillcolor    => '#8a5cde',
      :fillopacity  => 0.5,
    }.merge!(style)
    options.merge!(:geojson => source)
    @geojson = Mustache.render(template, options)
  end

  def geochloro(geodata)
    template = File.read(File.dirname(__FILE__) + '/templates/geochloro.js')
    @geochloro = Mustache.render(template, {:coloredgeos => geodata})
  end
  
end
