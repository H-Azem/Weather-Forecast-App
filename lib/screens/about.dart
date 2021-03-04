import 'dart:math';
import 'dart:ui';
import 'package:worldweather/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:worldweather/utilities/constants.dart';
import 'package:worldweather/services/weather.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:jalali_calendar/jalali_calendar.dart';
import 'package:persian_date/persian_date.dart';
import 'package:intl/intl.dart' as intl;
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:tapsell_plus/tapsell_plus.dart';

import '../Constant.dart';

class about extends StatefulWidget {
  @override
  _aboutState createState() => _aboutState();
}

class _aboutState extends State<about> {
  var data;

  var temp;
  var condition;
  // var clouds;
  // var wind;
  var icon;
  //var city;
  // var main;
  String lang = window.locale.languageCode;
  // var description;
  // var humidity;
  static DateTime now = DateTime.now();
  static var h = double.parse(intl.DateFormat('kk').format(now));

  dynamic getDate(add) {
    DateTime newDate = new DateTime(now.year, now.month, now.day + add);
    if (lang == 'fa') {
      if (newDate.day < 10) {
        PersianDate pDate = PersianDate(
            gregorian: (newDate.month < 10)
                ? "${newDate.year}-0${newDate.month}-0${newDate.day}"
                : "${newDate.year}-${newDate.month}-0${newDate.day}");
        return pDate;
      } else {
        PersianDate pDate = PersianDate(
            gregorian: (newDate.month < 10)
                ? "${newDate.year}-0${newDate.month}-${newDate.day}"
                : "${newDate.year}-${newDate.month}-${newDate.day}");
        return pDate;
      }
    } else {
      return newDate;
    }
  }



  static var m = now.month;
  static var d = now.day;

  WeatherModel weather = WeatherModel();
  var iName;

  @override
  void initState() {
    super.initState();
    var ran = Random().nextInt(3);
    if (ran == 1) {
      requestInterstitial();
      showInterstitial();
    }
  }

  void UpdateScreen(dynamic data) {
    setState(() {
      if (data == null) {
        InfoBgAlertBox(context: context);
      }
      temp = data['hourly'][0]['temp'];
      // minTemp = data['main']['temp_min'].toInt();
      // maxTemp = data['main']['temp_max'].toInt();
      //  humidity= data['main']['humidity'].toInt();
      //  wind= data['wind']['speed'];
      //  clouds = data['clouds']['all'];
      //  main = data['weather'][0]['main'];
      //   city = data['name'];
      //   description= data['weather'][0]['description'];
      //  outCome = weather.getMessage(temp);
    });
  }
 
  @override
  Widget build(BuildContext context) {
    Widget row(d, h) {
      return Column(
        children: [
          Directionality(
            textDirection: (lang == 'fa') ? TextDirection.rtl : TextDirection.ltr,
            child: Text('Name: World Weather\nVer: 1.2\nBy Hossein Azem\nWebSite: H-Azem.ir\nEmail: HosseinAzem@gmail.com\nمنبع مورد استفاده برای بخش سخن روز:\nCharbzaban.com\n\قدرت گرفته از:\nopenweathermap.org')
          ),
        ],
      );
    }

    if (h >= 19 && h < 24) {
      iName = 2;
    }
    if (h < 4 || h > 23) {
      iName = 1;
    }
    if (h >= 4 && h < 6) {
      iName = 3;
    }
    if (h >= 6 && h < 12) {
      iName = 5;
    }
    if (h >= 12 && h < 14) {
      iName = 4;
    }
    if (h >= 14 && h < 15) {
      iName = 5;
    }
    if (h >= 15 && h < 17) {
      iName = 0;
    }
    if (h >= 17 && h < 19) {
      iName = 3;
    }
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/$iName.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        //constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                    child: Column(children: [
                      row(0, 1),

                    ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void requestInterstitial() {
    TapsellPlus.requestInterstitial(
        Constant.TAPSELL_INTERSTITIAL,
        (zoneId) => response(zoneId),
        (zoneId, errorMessage) => error(zoneId, errorMessage));
  }

  void showInterstitial() {
    TapsellPlus.showAd(Constant.TAPSELL_INTERSTITIAL,
        opened: (zoneId) => opened(zoneId),
        closed: (zoneId) => closed(zoneId),
        error: (zoneId, errorMessage) => error(zoneId, errorMessage));
  }

  response(zoneId) {
    print("success: zone_id = $zoneId");
  }

  error(zoneId, errorMessage) {
    print('error caught: zone_id = $zoneId, message = $errorMessage');
  }

  opened(zoneId) {
    print("opened: zone_id = $zoneId");
  }

  closed(zoneId) {
    print("closed: zone_id = $zoneId");
  }
}
