import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart';

import 'package:line_animator/line_animator.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/pages/affectations/affectations_list_page.dart';
import 'package:tracking_user/pages/image/image_picker_page.dart';
import 'package:tracking_user/pages/tarcking_user_page.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';

class MapPage extends StatefulWidget {
  MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final lines = [
    [
      LatLng(33.573109, -7.589843),
    ]
  ];

  List<LatLng> getPoints(int index) {
    return lines[index].map((e) => e).toList();
  }

  List<LatLng> builtPoints = [];
  double markerAngle = 0.0;
  LatLng markerPoint = LatLng(0.0, 0.0);
  late List<LatLng> points;
  bool isReversed = false;
  ValueNotifier<LatLng> latLng = ValueNotifier<LatLng>(LatLng(0.0, 0.0));
// wrapper around the location API

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;

  Location location = new Location();
  late bool _serviceEnabled;
  PermissionStatus? _permissionGranted;
  late LocationData locationData;

  Future<dynamic> getLocation(UserProvider userProvider,
      AffectationProvider affectationProvider, BuildContext context) async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) _serviceEnabled = await location.requestService();

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }
    locationData = await location.getLocation();

    setState(() {
      markerPoint = LatLng(locationData.latitude!.toDouble(),
          locationData.longitude!.toDouble());
    });
    // await userProvider.getAffectation(context);
    await affectationProvider.calculateDistance();

    // lines[0] =[LatLng(locationData.latitude!.toDouble(), locationData.longitude!.toDouble())];
  }

  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final affectationProvider =
        Provider.of<AffectationProvider>(context, listen: false);

    userProvider.sendRepairTechnicien();

    points = getPoints(0);

    getLocation(userProvider, affectationProvider, context);
    setInitialLocation();
    affectationProvider.getAffectation(context);

    location = Location();
    polylinePoints = PolylinePoints();

    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event

    super.initState();
  }

  late LocationData currentLocation;

  void setInitialLocation() async {
    currentLocation = await location.getLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final affectationProvider = Provider.of<AffectationProvider>(context);

    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                style: style,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PolylineORSPage()),
                  );
                },
                child: const Text('Entrer sur lap map'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: style,
                onPressed: () {
                  userProvider.startTicket(
                      userProvider.latLngUser.latitude.toString(),
                      userProvider.latLngUser.longitude.toString());
                },
                child: const Text('Comencée le travaille'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: style,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AffectationListPage()),
                  );
                },
                child: const Text('Entrer sur la liste '),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: style,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImagePickerWidget()),
                  );
                },
                child: const Text('Choisir une image '),
              ),
            ],
          ),
        ));
  }

  // @override
  // void didUpdateWidget(MyHomePage oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  // }
}
