var map = L.map('MapleLeaflet').setView({{center}}, {{zoom}});

L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
	attribution: 'Leaflet, OSM, MapleLeaflet'
}).addTo(map);

