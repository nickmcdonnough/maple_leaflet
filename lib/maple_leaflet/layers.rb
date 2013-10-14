#
# Creates markers, circles, popups.  Inherits GeoJSON.
#

class Layers < GeoJSON

  def marker (coords, caption=nil)
    count		  = @markers.length
    template	= File.read(File.dirname(__FILE__) + '/templates/marker.js')
    options		= {
      :count  => count,
      :point  => coords
    }
    @markers[count] = Mustache.render(template, options)
    caption ? popup("marker#{count}", caption) : return
  end

  def circle (coords, radius, caption=nil, opts={})
    count		  = @circles.length
    template	= File.read(File.dirname(__FILE__) + '/templates/circle.js')
	  options   = {
		  :weight			  => 1.5,
		  :color			  => '#999',
		  :opacity		  => 1,
    	:fillcolor		=> '#8a5cde',
    	:fillopacity	=> 0.5
    }.merge!(opts)
    options.merge!({:count => count, :point => coords, :radius => radius})
    @circles[count] = Mustache.render(template, options)
    caption ? popup("circle#{count}", caption) : return
  end
  
  def polygon (coords, caption=nil, opts={})
    count     = @polygons.length
    template  = File.read(File.dirname(__FILE__) + '/templates/polygon.js')
	  options   = {
		  :weight			  => 1.5,
		  :color			  => '#999',
		  :opacity		  => 1,
    	:fillcolor		=> '#8a5cde',
    	:fillopacity	=> 0.5
    }.merge!(opts)
    options.merge!({:count => count, :points => coords})
    @polygons[count] = Mustache.render(template, options)
    caption ? popup("polygon#{count}", caption) : return
  end

  def popup (target, caption)
	  count     = @popups.length
    template	= File.read(File.dirname(__FILE__) + '/templates/popup.js')
    options		= {
      :target   => target,
      :caption	=> caption,
    }
    @popups[count] = Mustache.render(template, options)
  end

end
