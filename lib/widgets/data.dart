import 'package:latlong2/latlong.dart';

final lines = [


[  
  LatLng(33.573109,-7.589843),
  LatLng(38.573109,-7.589843),
  LatLng(39.573109,-7.589843),
  LatLng(32.573109,-7.589843),
  LatLng(33.573109,-7.589843),
  LatLng(35.573109,-7.589843),
  LatLng(33.573109,-7.589843),
  LatLng(33.573109,-7.589843),
  LatLng(33.573109,-7.589843),
  LatLng(33.573109,-7.589843),
  LatLng(33.573109,-7.589843),
  LatLng(33.573109,-7.589843)
]
];

List<LatLng> getPoints(int index) {
  return lines[index].map((e) => e).toList();
}