function gmap_init() {
  var 
    button_center_map = document.getElementById('button-center-map'),
    countryMapStyles = [
      {
        featureType: "all",
        elementType: "labels",
        stylers: [
          { visibility: "off" }
        ]
      },
      {
        featureType: "administrative.country",
        elementType: "labels",
        stylers: [
          { visibility: "on" }
        ]
      },
      {
        featureType: "road",
        elementType: "geometry",
        stylers: [
          { visibility: "off" }
        ]
      }
    ],
    
    spotMapStyles = [
      {
        featureType: "all",
        elementType: "labels",
        stylers: [
          { visibility: "on" }
        ]
      },
      {
        featureType: "road",
        elementType: "geometry",
        stylers: [
          { visibility: "on" }
        ]
      }
    ],
    
    countryMapOptions = {
      styles: countryMapStyles,
      mapTypeId: google.maps.MapTypeId.HYBRID,
      panControl: false,
      scaleControl: true,
      rotateControl: true,
      mapTypeControl: true,
      mapTypeControlOptions: {
          style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
          position: google.maps.ControlPosition.BOTTOM_LEFT
      },
      zoomControl: true,
      zoomControlOptions: {
          style: google.maps.ZoomControlStyle.LARGE,
          position: google.maps.ControlPosition.LEFT_BOTTOM
      },
  
      //streetViewControl: true,
      streetViewControlOptions: {
          position: google.maps.ControlPosition.LEFT_BOTTOM
      },
    },
    
    spotMapOptions = {
      zoom: 1,
      styles: spotMapStyles,
      mapTypeId: google.maps.MapTypeId.HYBRID,
      panControl: false,
      scaleControl: true,
      rotateControl: true,
      mapTypeControl: true,
      mapTypeControlOptions: {
          style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
          position: google.maps.ControlPosition.BOTTOM_LEFT
      },
      zoomControl: true,
      zoomControlOptions: {
          style: google.maps.ZoomControlStyle.LARGE,
          position: google.maps.ControlPosition.LEFT_BOTTOM
      },
  
      //streetViewControl: true,
      streetViewControlOptions: {
          position: google.maps.ControlPosition.LEFT_BOTTOM
      },
      
    },
    
    markers = gon.markers,
    
    google_markers_array = [],
    
    iconNormal = {
          path: google.maps.SymbolPath.CIRCLE,
          scale: 8,
          strokeColor: '#00FF99', //#003333
          strokeOpacity: 1,
          strokeWeight: 2,
          fillColor: '#D2006B',  //#00FF99
          fillOpacity: 1
    },
    
     iconHover = {
          path: google.maps.SymbolPath.CIRCLE,
          scale: 8,
          strokeColor: '#00FF99',
          strokeOpacity: 1,
          strokeWeight: 3,
          fillColor: '#D2336B',
          fillOpacity: 1
    },
    mode = "none";
  
//Placing map in the div

// for country#show action
  
  if (document.getElementById("country-map-canvas")) {
    map = new google.maps.Map(document.getElementById("country-map-canvas"),
    countryMapOptions);
    mode = "country";   
  }
  
// for spot#show action

  if (document.getElementById("spot-map-canvas")) {
    map = new google.maps.Map(document.getElementById("spot-map-canvas"),
    spotMapOptions);
    mode = "spot";      
  }
  
//for spot#edit action

  if (document.getElementById("edit-spot-map-canvas")) {
    map = new google.maps.Map(document.getElementById("edit-spot-map-canvas"),
    spotMapOptions);
    mode = "edit";      
  }
  
 //for spot#new action
 
  if (document.getElementById("new-spot-map-canvas")) {
    map = new google.maps.Map(document.getElementById("new-spot-map-canvas"),
    spotMapOptions);
    mode = "new";     
  }



// Placing markers and infoWindow

  var 
    infowindow = new google.maps.InfoWindow(),
    marker, 
    i,
    myBounds = new google.maps.LatLngBounds();
  
  
  if (markers) {  
    for (i = 0; i < markers.length; i++) {  
      myLatLng = new google.maps.LatLng(markers[i][1], markers[i][2]);
      
      marker = new google.maps.Marker({
        position: myLatLng,
        map: map,
        icon: iconNormal,
        title: markers[i][0],
      });
      
      // add marker to globar array
      google_markers_array.push(marker);
      
      // extend boundaries to include current marker coordinates
      myBounds.extend(myLatLng);
      
      // listeners for 'edit' mode
      if (mode == 'edit' || mode =='new') {
        marker.setDraggable (true);
        lat_field = $("#spot_latitude");
        lon_field = $("#spot_longitude");

        google.maps.event.addListener(marker,'dragend',function(event) {
          lat_field.val(event.latLng.lat());
          lon_field.val(event.latLng.lng());
        });
        
        google.maps.event.addListener(map,'click',function(event) {
          lat_field.val(event.latLng.lat());
          lon_field.val(event.latLng.lng());
          marker.setPosition(event.latLng);
        });
        
      
      //listeners for 'spot' and 'country' modes
      } else  {
        google.maps.event.addListener(marker, 'mouseover', (function(marker, i) {
          return function() {
            windowContent = "<span class=map-info-window>" + markers[i][0] + "</span>"
            infowindow.setContent(windowContent);
            infowindow.open(map, marker);
            marker.setIcon(iconHover);
          }
        })(marker, i));
        
        google.maps.event.addListener(marker, 'mouseout', (function(marker, i) {
          return function() {
            infowindow.close(map, marker);
            marker.setIcon(iconNormal);
          }
        })(marker, i));
        
        if (mode == 'country') {
          google.maps.event.addListener(marker, 'click', (function(marker, i) {
            return function() {
              window.location.href = markers[i][3]; 
            }
          })(marker, i));
        }
      }
    }
    // check if we have more than 1 marker
    if (google_markers_array.length > 1) {
      var mc = new MarkerClusterer(map, google_markers_array);
    }
  }

// Setting bounds (center and zoom)

  
  
  function scaleToFit() {
    if (i > 1) {
      map.fitBounds(myBounds);
    }
    else { 
      if (mode == "country" || mode =="new") {
        // 'country' and 'new' modes
        
        var geocoder = new google.maps.Geocoder();
        geocoder.geocode( { 'address': gon.country}, function(results, status) {
          if (status == google.maps.GeocoderStatus.OK) {
            map.setCenter(results[0].geometry.location);
            map.fitBounds(results[0].geometry.viewport);
            if (mode =="new") 
              marker.setPosition(results[0].geometry.location);
          }
        });
      }
      else {
        // 'spot' and 'edit' modes
        map.setCenter(marker.getPosition());
        map.setZoom (15);
      }
  
    }
    
  }
  
  /// Init and bindings
  
  scaleToFit();
  
  // if it's country page
	if (button_center_map) {
		button_center_map.onclick = scaleToFit
	}
	
// 	window.addEventListener('orientationchange', scaleToFit)
// 	window.addEventListener('resize', scaleToFit)

}

google.maps.event.addDomListener(window, 'load', gmap_init);
