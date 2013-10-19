#
# Maple#new takes an options hash that assigns the map center, width
# height, and default zoom.  If an options hash is not passed default
# values are used.
#
# Maple#drawmap takes no parameters and concatenates a large string
# containing all of the elements added by the user.  It is an ugly way
# of going about it and will be the first thing I tackle for the next
# version.
#

class MapleLeaflet < Layers
 
  def initialize (options = { :center => [39.50, -95.65],
                  :width => 660, :height => 440, :zoom => 4 })    
    temp1 = File.read(File.dirname(__FILE__) + '/templates/createmap.js')
    @createmap = Mustache.render(temp1, options)
    
    # render initialize options hash into HTML
    temp2 = File.read(File.dirname(__FILE__) + '/templates/html.html')
    @htmltags = Mustache.render(temp2, options)
    
    # empty arrays for storing objects
    @markers, @circles, @polygons, @popups = [], [], [], []
    @geojson = String.new
  end
 
  def drawmap
    [
      @markers,
      @circles,
      @polygons,
      @popups,
      @htmltags,
      @createmap,
      @geojson,
      @geochoro,
      '</script>'
    ].join
  end

end
