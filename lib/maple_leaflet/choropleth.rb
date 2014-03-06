#
# Formats provided JSON for drawing choropleth maps.
# Source data is used to determine color.  Source data bound to popup.
#
# Presumes GeoJSON data is formatted as a FeatureCollection as such:
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

module Choropleth
  def choropleth(data_csv, json_data, color="green")
    data = Hash[*data_csv.flatten]
    geojson = JSON.parse(json_data)

    checks = geojson["features"].map { |h| data.has_key? h["id"] }
    if checks.all? { |c| c == true }
      floats  = Hash[data.map { |k, v| [k, v.to_f] }]
      ranked  = rank(floats)
      colored = add_colors(ranked, color)
    else
      raise 'Not all data points have a corresponding GeoJSON object.'
    end

    geojson["features"].each do |feature|
      hue   = colored[feature["id"]]
      style = {
        "weight"      => 1,
        "color"       => "white",
        "opacity"     => 1,
        "fillColor"   => hue,
        "fillOpacity" => 1
      }
      feature["properties"]["popupContent"] = "#{feature["id"]}: #{floats[feature["id"]]}"
      feature["properties"]["style"] = style
    end
    geochoro(geojson.to_json)
  end

  private

  def rank(hsh)
    data = Hash[hsh.sort_by { |k, v| v }]
    avg = data.values.inject(:+) / data.size
    a = data.values.map { |x| (x - avg)**2 }.inject(:+) / data.size
    std = a**0.5
    data.each_key { |k| data[k] = (data[k] / std).to_i }
  end

  def add_colors(data_hsh, color)
    col = colorize(color)
    data_hsh.each_key { |k| data_hsh[k] = col[data_hsh[k] - 1] }
  end
end
