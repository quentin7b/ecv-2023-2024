import 'dart:ui';

import 'package:classroom_check/models/room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RoomScreen extends StatelessWidget {
  final Room room;

  const RoomScreen({
    super.key,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_room.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: ListView(
            children: [
              Card(
                margin: const EdgeInsets.all(0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    room.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FlutterMap(
                    mapController: MapController(),
                    options: MapOptions(
                      initialCenter: LatLng(room.latitude, room.longitude),
                      initialZoom: 17,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName:
                            'dev.fleaflet.flutter_map.example',
                        // Plenty of other options available!
                      ),
                      MarkerLayer(markers: [
                        Marker(
                          width: 48,
                          height: 48,
                          point: LatLng(room.latitude, room.longitude),
                          child: const Icon(
                            Icons.location_on,
                            size: 48,
                            color: Colors.red,
                          ),
                        )
                      ])
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Rejoindre le cours'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: const Text('Pardon, je me suis trompé de salle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
