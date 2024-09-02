// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:url_launcher/url_launcher.dart';

// class Maps extends StatefulWidget {
//   static String routeName = "maps";
//   @override
//   _MapsState createState() => _MapsState();
// }

// class _MapsState extends State<Maps> {
//   final MapController _mapController = MapController();
//   LatLng _currentLocation = LatLng(51.509364, -0.128928);
//   double _currentZoom = 9.2;

//   void _searchLocation(String query) {
//     setState(() {
//       _currentLocation = LatLng(48.8566, 2.3522);
//       _mapController.move(_currentLocation, 12.0);
//     });
//   }

//   void _zoomIn() {
//     setState(() {
//       _currentZoom += 1;
//       _mapController.move(_currentLocation, _currentZoom);
//     });
//   }

//   void _zoomOut() {
//     setState(() {
//       _currentZoom -= 1;
//       _mapController.move(_currentLocation, _currentZoom);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Flutter Map Example'),
//         ),
//         body: FlutterMap(
//           options: MapOptions(
//             initialCenter: LatLng(51.509364, -0.128928),
//             initialZoom: 9.2,
//           ),
//           children: [
//             TileLayer(
//               urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//               userAgentPackageName: 'com.example.app',
//               maxNativeZoom: 19,
//             ),
//             RichAttributionWidget(
//               attributions: [
//                 TextSourceAttribution(
//                   'OpenStreetMap contributors',
//                   onTap: () async => await launchUrl(
//                       Uri.parse('https://openstreetmap.org/copyright')),
//                 ),
//               ],
//             ),
//           ],
//         ));
//   }
// }
