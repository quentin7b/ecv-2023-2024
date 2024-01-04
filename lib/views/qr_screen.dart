import 'dart:convert';
import 'dart:ui';

import 'package:classroom_check/models/room.dart';
import 'package:classroom_check/views/room_screen.dart';
import 'package:flutter/material.dart';
import 'package:native_barcode_scanner/barcode_scanner.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({super.key});

  void _onBarcodeDetected(BuildContext context, Barcode barcode) {
    try {
      final qrCodeValue = jsonDecode(barcode.value);
      final room = Room.fromJson(qrCodeValue);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return RoomScreen(
              room: room,
            );
          },
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Il semble que ce QR Code ne soit pas valide'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final height = constraints.maxHeight;
                // Get the smallest size of the screen
                final maxSize = width > height ? height : width;
                final containerSize = maxSize * 0.9;
                final barcodeContainerSize = maxSize * 0.85;
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(.25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.7),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  width: containerSize,
                  height: containerSize,
                  child: Center(
                    child: SizedBox(
                      width: barcodeContainerSize,
                      height: barcodeContainerSize,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BarcodeScannerWidget(
                          stopScanOnBarcodeDetected: false,
                          onBarcodeDetected: (barcode) {
                            _onBarcodeDetected(context, barcode);
                          },
                          onError: (error) {
                            print('Barcode Error: $error');
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
