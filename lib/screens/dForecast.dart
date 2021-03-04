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

class dForecast extends StatefulWidget {
  dForecast(this.data);
  final data;
  @override
  _dForecastState createState() => _dForecastState(data);
}

class _dForecastState extends State<dForecast> {
  _dForecastState(this.data);
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

  String day(add) {
    DateTime newDate = new DateTime(now.year, now.month, now.day + add);
    int wd = newDate.weekday;
    if (lang == 'fa') {
      if (wd == 1) {
        return '2 شنبه';
      }
      if (wd == 2) {
        return '3 شنبه';
      }
      if (wd == 3) {
        return '4 شنبه';
      }
      if (wd == 4) {
        return '5 شنبه';
      }
      if (wd == 5) {
        return 'آدینه';
      }
      if (wd == 6) {
        return 'شنبه';
      }
      if (wd == 7) {
        return '1 شنبه';
      }
    } else {
      if (wd == 1) {
        return 'Mon';
      }
      if (wd == 2) {
        return 'Tue';
      }
      if (wd == 3) {
        return 'Wed';
      }
      if (wd == 4) {
        return 'Thu';
      }
      if (wd == 5) {
        return 'Fri';
      }
      if (wd == 6) {
        return 'Sat';
      }
      if (wd == 7) {
        return 'Sun';
      }
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
    UpdateScreen(widget.data);
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
      return Directionality(
        textDirection: (lang == 'fa') ? TextDirection.rtl : TextDirection.ltr,
        child: Card(
          color: Colors.white70,
          margin: EdgeInsets.fromLTRB(10, 3, 10, 2),
          child: ListTile(
            title: Row(
              children: [
                Column(
                  children: [
                    new Image.asset(
                        'images/Icons/${data['daily'][h]['weather'][0]['icon']}.png',
                        width: 40),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text(
                          (data['daily'][h]['temp']['min'].toInt()).toString() +
                              '°/' +
                              (data['daily'][h]['temp']['max'].toInt())
                                  .toString() +
                              '°',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontFamily: 'Spartan MB')),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Text((lang == 'fa') ? 'باد' : 'Wind',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                                fontFamily:
                                    (lang == 'fa') ? 'vazir' : 'Spartan MB')),
                        Text(
                            (lang == 'fa')
                                ? (data['daily'][h]['wind_speed'].toInt())
                                        .toString() +
                                    " م/ث"
                                : (data['daily'][h]['wind_speed'].toInt())
                                        .toString() +
                                    " m/s",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontFamily:
                                    (lang == 'fa') ? 'vazir' : 'Spartan MB')),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(data['daily'][h]['weather'][0]['description'],
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                            fontFamily:
                                (lang == 'fa') ? 'vazir' : 'Spartan MB')),
                  ),
                )
              ],
            ),
            leading: Text(
              day(d) +
                  "\n" +
                  (getDate(d).month).toString() +
                  "/" +
                  (getDate(d).day).toString(),
              style: TextStyle(
                fontFamily: (lang == 'fa') ? 'vazir' : 'Spartan MB',
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ),
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
                      row(1, 2),
                      row(2, 3),
                      row(3, 4),
                      row(4, 5),
                      row(5, 6),
                      row(6, 7),
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
