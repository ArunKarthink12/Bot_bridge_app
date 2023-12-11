import 'dart:async';
import 'dart:convert';
// import 'dart:js';

import 'package:botbridge_green/Model/ApiException.dart';
import 'package:botbridge_green/Utils/LocalDB.dart';
// import 'package:botbridge_green/ViewModel/locationUpdate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class LocationController extends GetxController {
  RxInt timer = 0.obs;
  RxString lat = ''.obs;
  // RxDouble lon = 0.0.obs;

  // String lon = "";
  @override
  void onInit() {
    super.onInit();
    // Your initialization code goes here
    Timer.periodic(Duration(seconds: 5), (Timer t) {
      permission();
    });
    // permission();
  }

  // @override
  // void onClose() {
  //   // Cleanup code goes here
  //   print('Controller disposed');
  //   super.onClose();
  // }

  permission() async {
    var accessLocation = await Permission.location.status;

    if (!accessLocation.isGranted) {
      await Permission.location.request();
    }

    if (await Permission.location.isGranted) {
      // setstate()
      // Timer.periodic(Duration(seconds: 5), (Timer t) {
      timer = timer + 1;

      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.

      try {
        serviceEnabled = await Geolocator.isLocationServiceEnabled();

        if (serviceEnabled) {
          await Geolocator.requestPermission();
          Position position = await Geolocator.getCurrentPosition(
              forceAndroidLocationManager: false,
              desiredAccuracy: LocationAccuracy.best);
          debugPrint('location: ${position.latitude}');
          List<Placemark> addresses = await placemarkFromCoordinates(
              position.latitude, position.longitude);
          var first = addresses.first;
          LocalDB.setLDB("latitude", position.latitude.toString());
          LocalDB.setLDB("longitude", position.longitude.toString());
          lat.value = addresses.first.locality.toString();
          print("ccc::${lat.value}");

          Map<String, dynamic> data = {
            "userNo": 2,
            "latitude": position.latitude.toString(),
            "longitude": position.longitude.toString()
          };
          var json = jsonEncode(data);
          print(json);
          Future.delayed(
            Duration.zero,
            () async {
              try {
                var response = await http.post(
                  Uri.parse(
                      'http://lims.yungtrepreneur.com/HCAPI/api/ExternalAPI/GetLiveLocation'),

                  body: json,
                  headers: {
                    "Content-Type": "application/json",
                  },
                  // {
                  //   "userNo": '2',
                  //   "latitude": position.latitude.toString(),
                  //   "longitude": position.longitude.toString()
                  // }
                );
                print("resp${response.body}");
              } catch (e) {
                print("error::$e");
                rethrow;
              }
              // locationmain(context, data, true);
            },
          ).then((value) => {print("Success")});
          // lon.value = position.longitude;
          // first.country.toString();

          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            permission = await Geolocator.requestPermission();
            if (permission == LocationPermission.deniedForever) {
              // fun('Location',
              //     'No location Permission in this app Go to Settings to Turn On Location');
              await Geolocator.openAppSettings();
              if (permission == LocationPermission.unableToDetermine) {
                // fun('Location',
                //     'No location Permission in this app Go to Settings to Turn On Location');
              }
            }
          }
        }
      } catch (e) {
        print("debug::$e");
        rethrow;
      }
      print("hi! :: $timer");
      // });
      update();
    } else {
      SystemNavigator.pop();
    }
  }
}
