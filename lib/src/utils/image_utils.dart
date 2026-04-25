/*

  Created by: Bakhromjon Polat
  Created on: Nov 29 2025 14:52:24

*/

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<ui.Image> getImageDimensions(String imagePath) async {
  final Uint8List bytes;
  if (imagePath.startsWith('assets/') || imagePath.startsWith('packages/')) {
    final ByteData data = await rootBundle.load(imagePath);
    bytes = data.buffer.asUint8List();
  } else {
    bytes = await File(imagePath).readAsBytes();
  }
  return decodeImageFromList(bytes);
}
