import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';

Future<String> imageProviderToBase64(ImageProvider imageProvider) async {
    // Create a completer to handle the asynchronous image loading
    final completer = Completer<Uint8List>();
    
    // Convert ImageProvider to ImageStream and listen for the image data
    final imageStream = imageProvider.resolve(ImageConfiguration.empty);
    final listener = ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) async {
      final byteData = await imageInfo.image.toByteData(format: ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();
      if (!completer.isCompleted) {
        completer.complete(bytes);
      }
    });
    
    imageStream.addListener(listener);
    
    // Wait for the image bytes
    final bytes = await completer.future;
    
    // Remove the listener when done
    imageStream.removeListener(listener);
    
    // Convert to base64
    return base64Encode(bytes);
  }
  

Future<Uint8List> imageProviderToUint8List(ImageProvider imageProvider) async {
    // Create a completer to handle the asynchronous image loading
    final completer = Completer<Uint8List>();
    
    // Convert ImageProvider to ImageStream and listen for the image data
    final imageStream = imageProvider.resolve(ImageConfiguration.empty);
    final listener = ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) async {
      final byteData = await imageInfo.image.toByteData(format: ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();
      if (!completer.isCompleted) {
        completer.complete(bytes);
      }
    });
    
    imageStream.addListener(listener);
    
    // Wait for the image bytes
    final bytes = await completer.future;
    
    // Remove the listener when done
    imageStream.removeListener(listener);
    
    // Convert to base64
    return bytes;
  }


Future<Uint8List> getRoundedImageBytes(ImageProvider imageProvider) async {
    try {
      // Load the image
      final imageStream = imageProvider.resolve(ImageConfiguration.empty);
      final completer = Completer<ImageInfo>();
      final listener = ImageStreamListener((ImageInfo info, _) {
        if (!completer.isCompleted) completer.complete(info);
      });
      imageStream.addListener(listener);
      
      final imageInfo = await completer.future;
      imageStream.removeListener(listener);
      
      // Create a picture recorder and canvas for drawing
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder);
      final paint = Paint();
      
      // Create a rounded rectangle clip
      final radius = Radius.circular(100); // Adjust for desired roundness
      final rect = Rect.fromLTWH(0, 0, 
          imageInfo.image.width.toDouble(), 
          imageInfo.image.height.toDouble());
      
      // Draw rounded image
      canvas.save();
      canvas.clipPath(Path()..addRRect(RRect.fromRectAndRadius(rect, radius)));
      canvas.drawImage(imageInfo.image, Offset.zero, paint);
      canvas.restore();
      
      // Convert to byte data
      final picture = recorder.endRecording();
      final img = await picture.toImage(imageInfo.image.width, imageInfo.image.height);
      final byteData = await img.toByteData(format: ImageByteFormat.png);
      
      return byteData!.buffer.asUint8List();
    } catch (e) {
      debugPrint('Error rounding image: $e');
      // Fallback to original if rounding fails
      return imageProviderToUint8List(imageProvider);
    }
  }