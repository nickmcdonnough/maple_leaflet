#
# Formats provided JSON for drawing chloropleth maps.
# Source data is used to determine color.  Source data bound to popup.
#
# Presumes JSON data is formatted as a FeatureCollection as such:
#
#   {
#     "type": "FeatureCollection",
#     "features": [{
#       "type": "Feature",
#       "id": "XXX",
#       "properties": {
#         "name": "XXX"
#       },
#       "geometry": {
#         "type": "Polygon",
#         "coordinates": [ COORDINATES ]
#       }
#     }
#   }
#
# "id" should correspond to the first column of your CSV data file.
# "name" is arbitrary but could be a state, county, or block group.
# "geometry":{"type" can be either a Polygon or Multipolygon.
# "coordinates" you better have these if you want a map!
#

module Chloro

  def rank(data_hsh)
    avg = data_hsh.values.inject(:+)/data_hsh.size
    a = data_hsh.values.map{|x| (x-avg)**2}.inject(:+)/data_hsh.size
    std = Math.sqrt(a)
    data_hsh.each_key{|k| data_hsh[k]=(data_hsh[k]/std).to_i}
  end

  def add_colors(data_hsh, color)
    col = colorize(color)
    data_hsh.each_key{|k| data_hsh[k]=col[data_hsh[k]-1]}
  end

  def chloropleth(data_csv, json_data, color="green")
    flat     = Hash[*(data_csv.flatten)]
    floats   = Hash[flat.map{|k,v| [k, v.to_f]}]
    data_hsh = Hash[floats.sort_by{|k,v| v}]
    
    json_hsh = JSON.parse(json_data)

    ranked   = rank(data_hsh)
    colored  = add_colors(ranked, color)

    json_hsh["features"].each {|obj|
      hue   = colored[obj["id"]]
      style = {"weight"=>1.5, "color"=>"white", "opacity"=> 1, "fillColor"=>hue, "fillOpacity"=> 1} 
      obj["properties"]["popupContent"] = "#{obj["id"]}: #{floats[obj["id"]]}"
      obj["properties"]["style"] = style
    }
    geochloro(json_hsh.to_json)
  end

end
