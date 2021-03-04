import 'dart:async';
import 'dart:ui';

import 'package:worldweather/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';
import 'package:worldweather/services/weather.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:connectivity/connectivity.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String lang = window.locale.languageCode;
  @override
  void initState() {
    super.initState();

    getLocation();
  }

  void getLocation() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
    } else if (connectivityResult == ConnectivityResult.wifi) {
    } else {
      WarningAlertBoxCenter(
          context: context,
          messageText: (lang == 'fa')
              ? 'اتصال به اینترنت را بررسی کنید'
              : 'No internet connection',
          buttonText: (lang == 'fa') ? 'خروج' : 'Exit');
    }
    WeatherModel weather = WeatherModel();
    var data = await weather.getLoc();

    if (data != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(data);
      }));
    } else {
      InfoAlertBoxCenter(
          context: context,
          infoMessage: (lang == 'fa')
              ? 'برنامه برای اجرا نیاز به دسترسی به موقعیت شما دارد. دوباره برنامه را اجرا کنید و دسترسی های لازم را بدهید.'
              : 'This app need to location permission. Please run the app again and accept the permission.',
          buttonText: (lang == 'fa') ? 'خروج' : 'Exit');
    }
  }

  @override
  Widget build(BuildContext context) {
    var _timer = new Timer(const Duration(seconds: 15), () async {
      WeatherModel w = WeatherModel();
      var newD = (lang == 'fa')? await w.getCity('Tehran') :await w.getCity('London');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(newD);
      }));
    });
      return Scaffold(
      body: Center(
          child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
      )),
    );
  }
}
