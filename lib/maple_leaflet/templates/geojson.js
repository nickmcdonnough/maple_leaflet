var jsonStyle = {
	weight: {{weight}},
	color: "{{color}}",
	opacity: {{opacity}},
	fillColor: "{{fillcolor}}",
	fillOpacity: {{fillopacity}}
};

var geoData = {{{geojson}}};

var geoComplete = L.geoJson(geoData, {
    style: jsonStyle,
      onEachFeature: function (feature, layer) {
            layer.bindPopup(feature.properties.popupContent);
              }
}).addTo(map);

