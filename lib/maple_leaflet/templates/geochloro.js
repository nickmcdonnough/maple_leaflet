var geoData = {{{coloredgeos}}};

var geoComplete = L.geoJson(geoData, {
        style: function(feature) {
                return feature.properties && feature.properties.style;
        },
        onEachFeature: function (feature, layer) {
                layer.bindPopup(feature.properties.popupContent);
        }
}).addTo(map);

