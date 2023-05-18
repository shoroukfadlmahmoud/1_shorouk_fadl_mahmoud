
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class TrackLocation extends StatefulWidget {


  @override
  State<TrackLocation> createState() => _TrackLocationState();
}

class _TrackLocationState extends State<TrackLocation> {
  MapController controller = MapController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           backgroundColor: Colors.teal,
      ),
      body: OSMFlutter(
        controller:controller,
        trackMyPosition: true,
        initZoom: 13,
        minZoomLevel: 8,
        maxZoomLevel: 19,
        stepZoom: 1.0,
        userLocationMarker: UserLocationMaker(
          personMarker: const MarkerIcon(
            icon: Icon(
              Icons.person_pin_circle_outlined,
              color: Colors.teal,
              size: 48,
            ),
          ),
          directionArrowMarker:const MarkerIcon(
            icon: Icon(
              Icons.person_pin_circle_outlined,
              size: 48,
              color: Colors.teal ,
            ),
          ),
        ),
        roadConfiguration:const RoadOption(
          roadColor: Colors.yellowAccent,
        ),
        markerOption: MarkerOption(
            defaultMarker: const MarkerIcon(
              icon: Icon(
                Icons.person_pin_circle,
                color: Colors.blue,
                size: 56,
              ),
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: ()async {
          await controller.currentLocation().then((value) async{
            await controller.enableTracking(enableStopFollow:true,);
          });

        },
        child: Icon(Icons.location_pin),
      ),
    );
  }
  bool get wantKeepAlive => true;

}

