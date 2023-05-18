import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import 'package:google_fonts/google_fonts.dart';

import 'Map_screen.dart';

class homepage extends StatefulWidget {
   homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/icon-tracking.png",
          ),
          SizedBox(height: 30,),
          ElevatedButton(
             style: ElevatedButton.styleFrom(
               backgroundColor: Colors.teal,
               fixedSize: Size(250, 50),

             ),
                onPressed: () {
                 Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TrackingLocation(),
                    ),).catchError((onError){
                        print(onError);
                  });

          }, child:
              Text("GET STARTED",style: GoogleFonts.acme(
                color: Colors.white,fontSize: 17
              ),)
          )
        ],
      ),
    );
  }
}
