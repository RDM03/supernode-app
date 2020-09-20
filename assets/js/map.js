// map.on('load', function () {

function _removeClusters(){
    if(map.getLayer('clusters')) {
        map.removeLayer('clusters');
        map.off('click', 'clusters',function(e){});
    } 

    if(map.getLayer('cluster-count')) {
        map.removeLayer('cluster-count');
    }

    if(map.getLayer('unclustered-point')) {
        map.removeLayer('unclustered-point');
    }

    if(map.getLayer('unclustered-point-field')) {
        map.removeLayer('unclustered-point-field');
    } 
    
    if(map.getLayer('clusters-points')) {
        map.removeLayer('clusters-points');
    } 

    if(map.getSource('gateways')){
        map.removeSource('gateways');
    }
}

function _addClusters(){
    map.addSource('gateways', {
        type: 'geojson',
        data: {
            'type': 'FeatureCollection',
            'features': window.gatewaysFeatures
        },
        cluster: true,
        clusterMaxZoom: 14, 
        clusterRadius: 50 
    });

    map.addLayer({
        id: 'clusters-points',
        type: 'circle',
        source: 'gateways',
        paint: {
            'circle-opacity': 0.75,
            'circle-color': '#1c1478',
            'circle-radius': 16
        }
    });

    map.addLayer({
        id: 'clusters',
        type: 'circle',
        source: 'gateways',
        paint: {
            'circle-color': 'rgba(0, 0, 0, 0)',
            'circle-radius': [
                'step',
                ['get', 'point_count'],
                20,
                100,
                30,
                750,
                40
            ]
        }
    });

    map.addLayer({
        id: 'cluster-count',
        type: 'symbol',
        source: 'gateways',
        filter: ['has', 'point_count'],
        layout: {
            'text-field': '{point_count_abbreviated}',
            'text-font': ['DIN Offc Pro Medium', 'Arial Unicode MS Bold'],
            'text-size': 12
        },
        paint: {
            'text-color': '#fff'
        }
    });

    map.addLayer({
        id: 'unclustered-point-field',
        type: 'symbol',
        source: 'gateways',
        filter: ['!', ['has', 'point_count']],
        layout: {
            'text-font': ['DIN Offc Pro Medium', 'Arial Unicode MS Bold'],
            'text-size': 12,
            'text-field': '1'
        },
        paint: {
            'text-color': '#fff',
        }
    });

    map.on('click', 'clusters', function (e) {
        var features = map.queryRenderedFeatures(e.point, {
                layers: ['clusters']
            });

            var clusterId = features[0].properties.cluster_id;
            map.getSource('gateways').getClusterExpansionZoom(
                clusterId,
                function (err, zoom) {
                if (err) return;
                    
                map.easeTo({
                    center: features[0].geometry.coordinates,
                    zoom: zoom
                });
            }
        );
    });
}

// user location
var size = 100;

var pulsingDot = {
    width: size,
    height: size,
    data: new Uint8Array(size * size * 4),
        
    // get rendering context for the map canvas when layer is added to the map
    onAdd: function () {
        var canvas = document.createElement('canvas');
        canvas.width = this.width;
        canvas.height = this.height;
        this.context = canvas.getContext('2d');
    },
        
    // called once before every frame where the icon will be used
    render: function () {
        var duration = 1000;
        var t = (performance.now() % duration) / duration;
        
        var radius = (size / 2) * 0.3;
        var outerRadius = (size / 2) * 0.7 * t + radius;
        var context = this.context;
        
        // draw outer circle
        context.clearRect(0, 0, this.width, this.height);
        context.beginPath();
        context.arc(
            this.width / 2,
            this.height / 2,
            outerRadius,
            0,
            Math.PI * 2
        );
        context.fillStyle = 'rgba(41, 182, 246,' + (1 - t) + ')';
        context.fill();
        
        // draw inner circle
        context.beginPath();
        context.arc(
            this.width / 2,
            this.height / 2,
            radius,
            0,
            Math.PI * 2
        );
        context.fillStyle = 'rgba(41, 182, 246, 1)';
        context.strokeStyle = 'white';
        context.lineWidth = 2 + 4 * (1 - t);
        context.fill();
        context.stroke();
        
        // update this image's data with data from the canvas
        this.data = context.getImageData(
            0,
            0,
            this.width,
            this.height
        ).data;
        
        // continuously repaint the map, resulting in the smooth animation of the dot
        map.triggerRepaint();
        
        // return `true` to let the map know that the image was updated
        return true;
    }
};

function _removeUserMarker(){
    if (map.getLayer('user-point')) {
        map.removeLayer('user-point');
        map.removeSource('user-point');
        map.removeImage('pulsing-dot');
    }
}

function _addUserMarker(longitude,latitude,isShow){
    if (isShow && !map.getLayer('user-point')){
        map.addImage('pulsing-dot', pulsingDot, { pixelRatio: 2 });

        map.addSource('user-point', {
            'type': 'geojson',
            'data': {
                'type': 'FeatureCollection',
                'features': [
                    {
                        'type': 'Feature',
                        'geometry': {
                            'type': 'Point',
                            'coordinates': [longitude,latitude]
                        }
                    }
                ]
            }
        });

        map.addLayer({
            'id': 'user-point',
            'type': 'symbol',
            'source': 'user-point',
            'layout': {
                'icon-image': 'pulsing-dot'
            }
        });

    }
}

function _moveToMyLocation(longitude,latitude,isShow) {
    _addUserMarker(longitude,latitude,isShow);

    map.easeTo({
        center: [longitude,latitude],
        duration: 5000,
        zoom: 12,
    });
}

window.moveToMyLocation = _moveToMyLocation;
window.removeMyLocation = _removeUserMarker;
window.addMyLocation = _addUserMarker;
window.removeClusters = _removeClusters;
window.addClusters = _addClusters;
window.gatewaysFeatures = [];

// });