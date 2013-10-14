require 'maple_leaflet'

mapoptions = {
  :center => [39.952162,-75.196373],
  :width  => 800,
  :height => 450,
  :zoom   => 16
}

hvillage = [[39.952475, -75.202875],
            [39.953889, -75.202510],
            [39.953626, -75.200150],
            [39.952146, -75.200493]]

penn = MapleLeaflet.new(mapoptions)

penn.marker([39.950188, -75.190172], caption='Franklin Field')
penn.marker([39.950369, -75.196760], 'The Quad')
penn.marker([39.952644, -75.193595], 'Van Pelt Library')


penn.polygon(hvillage, caption='Hamilton Village')

File.write('penn_places.html', penn.drawmap)
