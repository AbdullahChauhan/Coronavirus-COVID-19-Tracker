import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Country {
  final String name;
  final int cases;

  Country(this.name, this.cases)
      : assert(name != null),
        assert(cases != null);
}

class MapScreen extends StatefulWidget {
  final List<dynamic> endpointsData;
  final double latitude;
  final double longitude;
  final bool confirmed;
  final bool recovered;
  final bool deaths;
  final String assetName;
  final String title;

  const MapScreen(
      {Key key,
      @required this.endpointsData,
      @required this.latitude,
      @required this.longitude,
      @required this.assetName,
      @required this.confirmed,
      @required this.recovered,
      @required this.deaths,
      @required this.title})
      : super(key: key);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController _controller;
  Map<Country, LatLng> allLatLongsData;

  @override
  void initState() {
    allLatLongsData = {};
    generateAllLatLongs();
    super.initState();
  }

  Map<Country, LatLng> generateAllLatLongs() {
    widget.endpointsData.forEach((value) {
      if (value['lat'] != null && value['long'] != null) {
        final latitude = value['lat'].toDouble();
        final longitude = value['long'].toDouble();
        final name = value['provinceState'] != null
            ? value['provinceState']
            : value['countryRegion'];
        final cases = widget.confirmed
            ? value['confirmed']
            : (widget.recovered ? value['recovered'] : value['deaths']);
        allLatLongsData[Country(name, cases)] = LatLng(latitude, longitude);
      }
    });
    return allLatLongsData;
  }

  Future<Set<Marker>> generateMarkers(Map<Country, LatLng> positions) async {
    List<Marker> markers = <Marker>[];
    final icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), widget.assetName);
    positions.forEach((k, v) {
      final marker = Marker(
          markerId: MarkerId(k.name),
          position: LatLng(v.latitude, v.longitude),
          icon: icon,
          infoWindow:
              InfoWindow(title: '${k.name}', snippet: 'Cases: ${k.cases}'),
          anchor: Offset(0.5, 0.5));
      markers.add(marker);
    });
    return markers.toSet();
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _controller.setMapStyle(mapStyle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            FutureBuilder(
              future: generateMarkers(allLatLongsData),
              initialData: Set.of(<Marker>[]),
              builder: (context, snapshot) => GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(widget.latitude, widget.longitude)),
                markers: snapshot.data,
                mapToolbarEnabled: false,
                rotateGesturesEnabled: false,
                scrollGesturesEnabled: true,
                // zoomGesturesEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                  getJsonFile("assets/map_styles/style.json").then(setMapStyle);
                },
              ),
            ),
            Positioned.fill(
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(23, 27, 30, .75),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              'Global ${widget.title} cases per country/region/state'
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    letterSpacing: .75,
                                  )),
                        ),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
