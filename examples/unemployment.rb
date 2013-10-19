require 'maple_leaflet'
require 'csv'

mapoptions = {
  :center => [39.50, -95.65],
  :width  => 800,
  :height => 450,
  :zoom   => 4
}

data = CSV.read('unemployment.csv')
geos = File.read('states.js')

unemp = MapleLeaflet.new(mapoptions)

unemp.choropleth(data, geos, color="purple")

File.write('unemployment.html', unemp.drawmap)
