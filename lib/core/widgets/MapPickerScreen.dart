import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({super.key});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  LatLng? selected;

  @override
  Widget build(BuildContext context) {
    final center = selected ?? LatLng(11.5564, 104.9282);

    return Scaffold(
      extendBody: true,
      body: FlutterMap(
        options: MapOptions(
          initialCenter: center,
          initialZoom: 14,
          onTap: (tapPosition, point) {
            setState(() => selected = point);
          },
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: "com.Flight.fly",
          ),
          if (selected != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: selected!,
                  width: 50,
                  height: 50,
                  child: const Icon(Icons.location_on, size: 45),
                ),
              ],
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          if (selected != null) {
            Navigator.pop(context, {
              "lat": selected!.latitude,
              "lng": selected!.longitude,
            });
          }
        },
      ),
    );
  }
}
