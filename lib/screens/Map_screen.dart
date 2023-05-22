
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';


class TrackingLocation extends StatefulWidget {


  @override
  State<TrackingLocation> createState() => _TrackingLocationState();
}

class _TrackingLocationState extends State<TrackingLocation> {

  final controller = MapController(
      initMapWithUserPosition: false,
      initPosition: GeoPoint(latitude: 	29.3198101, longitude: 30.8355472)

  );
  bool enabletracking = false;
  bool tim = false;


  List<GeoPoint> path = [];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

   onLocationChange()async
  {
    Timer.periodic( Duration(seconds: 3), (Timer t) async
    {
      if(tim == true)
        {
          GeoPoint currentLocation = await controller.myLocation();
          print("get current location");
          if(path.isEmpty || path[path.length-1] != currentLocation)
          {
            path.add(currentLocation);
            print("added my current location to list");
            print("$path");
            if (path.length >= 4) {
              await controller.drawRoadManually(
                  path,
                  const RoadOption(
                      roadColor: Colors.red,
                      roadWidth: 5
                  )
              );

            }
            if(path.length > 15){
              path.removeRange(0,10);
            }
          }

        }
      else{
        t.cancel();
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           backgroundColor: Colors.teal,
      ),
      body: OSMFlutter(
        controller:controller,
        initZoom: 13,
        minZoomLevel: 8,
        maxZoomLevel: 19,
        stepZoom: 1.0,
        onLocationChanged:(pos)=>onLocationChange(),

        userLocationMarker: UserLocationMaker(
          personMarker: const MarkerIcon(
            icon: Icon(
              Icons.person_pin_circle_outlined,
              color: Colors.red,
              size: 48,
            ),
          ),
           directionArrowMarker:const MarkerIcon(
            icon: Icon(
              Icons.person_pin_circle_outlined,
              size: 48,
               color: Colors.red ,
             ),
          ),
        ),
        markerOption: MarkerOption(
            defaultMarker: const MarkerIcon(
              icon: Icon(
                Icons.location_on_outlined,
                color: Colors.teal,
                size: 56,
              ),
            )
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: ()async {
           await controller.currentLocation().then((value) async{
             if (enabletracking == false){
               await controller.enableTracking();
               setState(() {
                 enabletracking = true ;
                 tim = true;
               });
               print("enable tracking ${enabletracking}");
             }
             else {
               await controller.disabledTracking();
               setState(() {
                 enabletracking = false ;
                 tim = false;
               });
               print("disable tracking ${enabletracking}");
               path.clear();
             }
          });
        },
        child: Icon(enabletracking?
                     Icons.my_location :Icons.location_disabled_sharp),
      ),

    );
  }


}

