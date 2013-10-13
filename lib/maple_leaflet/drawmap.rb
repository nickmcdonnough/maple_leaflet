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
    finalbuild = String.new
    layers = @markers+@circles+@polygons+@popups
    finalbuild << @htmltags unless @htmltags == nil
    finalbuild << @createmap unless @createmap == nil
    layers.each { |x| finalbuild << x.to_s }
    finalbuild << @geojson unless @geojson == nil
    finalbuild << @geochloro unless @geochloro == nil
    finalbuild << '</script>'
    return finalbuild
  end

end
