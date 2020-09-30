const initMap = (lat, lng) => {
    const myCoords = new google.maps.LatLng(lat, lng);
    const mapOptions = {
        center: myCoords,
        zoom: 14
    };
    const map = new google.maps.Map(document.getElementById('map'), mapOptions);
    const marker = new google.maps.Marker({
        position: myCoords,
        map: map
    });
}

window.initMap = initMap;
