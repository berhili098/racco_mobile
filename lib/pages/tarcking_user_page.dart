import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/model/affectation.dart';
import 'package:tracking_user/model/ticket_orange.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';

// import '../widgets/drawer.dart';

class NetworkHelper {
  NetworkHelper(
      {required this.startLng,
      required this.startLat,
      required this.endLng,
      required this.endLat});

  final String url = 'https://api.openrouteservice.org/v2/directions/';
  final String apiKey =
      '5b3ce3597851110001cf62486d5cfc78392446fba599f60bfeffe0dd';
  final String journeyMode =
      'driving-car'; // Change it if you want or make it variable
  final double startLng;
  final double startLat;
  final double endLng;
  final double endLat;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(
        '$url$journeyMode?api_key=$apiKey&start=$startLng,$startLat&end=$endLng,$endLat'));
    print(
        "$url$journeyMode?$apiKey&start=$startLng,$startLat&end=$endLng,$endLat");

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

class PolylineORSPage extends StatefulWidget {
  static const String route = 'polyline';

  @override
  State<PolylineORSPage> createState() => _PolylineORSPageState();
}

class _PolylineORSPageState extends State<PolylineORSPage> {
  final List<LatLng> polyPoints = []; // For holding Co-ordinates as LatLng
  final Set<Polyline> polyLines = {}; // For holding instance of Polyline
  final Set<Marker> markers = {}; // For holding instance of Marker
  var data;
  // Dummy Start and Destination Points
  double startLat = 44.837789;
  double startLng = -0.57918;
  double endLat = 41.902784;
  double endLng = 12.496366;

  var points = <LatLng>[];
  late LatLng markerUser;

  getLocationUser() {
    Location location = Location();
    location.onLocationChanged.listen((event) {
      polyPoints
          .add(LatLng(event.latitude!.toDouble(), event.longitude!.toDouble()));

      setState(() {
        markerUser =
            LatLng(event.latitude!.toDouble(), event.longitude!.toDouble());
      });
    });
  }

  @override
  void initState() {
    getLocationUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

        final affectationProvider = Provider.of<AffectationProvider>(context);


    List<Marker> _markers = [
      LatLng(13, 77.5),
      LatLng(13.02, 77.51),
      LatLng(13.05, 77.53),
      LatLng(13.155, 77.54),
      LatLng(13.159, 77.55),
      LatLng(13.17, 77.55),
    ]
        .map((point) => Marker(
              point: point,
              width: 60,
              height: 60,
              builder: (context) =>  const Icon(
                Icons.pin_drop,
                size: 60,
                color: Colors.blueAccent,
              ),
            ))
        .toList();

    var pointsGradient = <LatLng>[
      LatLng(startLat, startLng),
      LatLng(endLat, endLng),
    ];

    // void getJsonData() async {
    //   // Create an instance of Class NetworkHelper which uses http package
    //   // for requesting data to the server and receiving response as JSON format

    //   NetworkHelper network = NetworkHelper(
    //     startLat: startLat,
    //     startLng: startLng,
    //     endLat: endLat,
    //     endLng: endLng,
    //   );

    //   try {
    //     // getData() returns a json Decoded data
    //     data = await network.getData();

    //     // We can reach to our desired JSON data manually as following
    //     LineString ls =
    //         LineString(data['features'][0]['geometry']['coordinates']);

    //     for (int i = 0; i < ls.lineString.length; i++) {
    //       polyPoints.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
    //     }

    //     if (polyPoints.length == ls.lineString.length) {
    //       print(ls);
    //       //print(polyPoints);
    //     }
    //   } catch (e) {
    //     print(e);
    //     //print(polyPoints);
    //   }
    // }

    // getJsonData();
    return Scaffold(
      appBar: AppBar(title: Text('SAV')),
      // drawer: buildDrawer(context, PolylineORSPage.route),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
          
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(33.593,
                         -7.6179),
                  zoom: 10.0,
                ),
                children: [
                  TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c']),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                          points: polyPoints,
                          strokeWidth: 4.0,
                          color: Colors.transparent),
                    ],
                  ),

                  // MarkerLayer(markers: _markers),
                  MarkerLayer(markers: [
                    Marker(
                      point: LatLng(33.593,
                         -7.6179),
                      width: 60,
                      height: 60,
                      builder: (context) => Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                         color: Colors.white, 
                                        width: 5.0,
                                      ),
                                      color: const Color.fromRGBO(
                                          5, 119, 130, 1),
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                        "https://cdn-icons-png.flaticon.com/128/931/931633.png",
                                           color: Colors.white,
                                        fit: BoxFit.fitHeight),
                                  ),
                                ),
                    )
                  ]),
                  // StreamBuilder<List<TicketOrange>>(
                  //     stream: userProvider.getTickes(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         return MarkerLayer(
                  //             markers: snapshot.data!
                  //                 .map(
                  //                   (e) => Marker(
                  //                     point: LatLng(double.parse(e.lat!),
                  //                         double.parse(e.lang!)),
                  //                     width: 60,
                  //                     height: 60,
                  //                     builder: (context) => Container(
                  //                 decoration: BoxDecoration(
                  //                     border: Border.all(
                  //                        color: Colors.white, 
                  //                       width: 5.0,
                  //                     ),
                  //                     color: const  Color.fromARGB(255, 230, 156, 60),
                  //                     shape: BoxShape.circle),
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.all(8.0),
                  //                   child: Image.network(
                  //                       "https://cdn-icons-png.flaticon.com/128/1069/1069138.png",
                  //                          color: Colors.white,
                  //                       fit: BoxFit.fitHeight),
                  //                 ),
                  //               ),
                  //                   ),
                  //                 )
                  //                 .toList());
                  //       }

                  //       return const MarkerLayer(markers: []);
                  //     })



                         
                           MarkerLayer(
                              markers: affectationProvider.affectations
                                  .map(
                                    (e) => Marker(
                                      point: LatLng(e.lat!,
                                     e.lng!),
                                      width: 60,
                                      height: 60,
                                      builder: (context) => Container(
                                        alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                         color: Colors.white, 
                                        width: 5.0,
                                      ),
                                      color:  affectationProvider.affectations.indexOf(e) <3 ? const Color.fromARGB(255, 230, 60, 60) :const  Color.fromARGB(255, 230, 156, 60),
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:  Text(  e.id.toString(),textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)
                                    
                                    
                                    // Image.network(
                                    //     "https://cdn-icons-png.flaticon.com/128/1069/1069138.png",
                                    //        color: Colors.white,
                                    //     fit: BoxFit.fitHeight),
                                  ),
                                ),
                                    ),
                                  )
                                  .toList())
                       


                  // PolylineLayer(
                  //   polylines: [
                  //     Polyline(
                  //       points: pointsGradient,
                  //       strokeWidth: 4.0,
                  //       gradientColors: [
                  //         Color(0xffE40203),
                  //         Color(0xffFEED00),
                  //         Color(0xff007E2D),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//Create a new class to hold the Co-ordinates we've received from the response data

class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}
