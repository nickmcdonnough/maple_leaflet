#
# maple_leaflet.rb
#

$:.unshift File.join(File.dirname(__FILE__), '.')

require 'json'
require 'mustache'

require 'maple_leaflet/geojson'
require 'maple_leaflet/layers'
require 'maple_leaflet/drawmap'
require 'maple_leaflet/choropleth'
require 'maple_leaflet/colors'
require 'maple_leaflet/version'

include Colors
include Choropleth
