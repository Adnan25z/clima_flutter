import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async {
    LocationPermission permission;

    // Handle permissions first
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied');
      return;
    }

    // New way using locationSettings
    final settings = LocationSettings(
      accuracy: LocationAccuracy.low,
      distanceFilter: 0,
      timeLimit: Duration(seconds: 10),
    );
    try{
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: settings,
      );

      latitude = position.latitude;
      longitude = position.longitude;
    }
    catch (ex){
      print(ex);
    }
  }
}