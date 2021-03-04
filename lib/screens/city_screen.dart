import 'dart:math';
import 'dart:ui';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:worldweather/utilities/constants.dart';
import 'package:intl/intl.dart' as intl;

import '../Constant.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  var city;
  var iName;
  static DateTime now = DateTime.now();
  static var h = double.parse(intl.DateFormat('kk').format(now));
  String lang = window.locale.languageCode;
  String adImage = "", adTitle = "";

  @override
  Widget build(BuildContext context) {
    String adImage = "", adTitle = "";
   
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/$iName.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
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
          Directionality(
            textDirection: (lang == 'fa')?TextDirection.rtl:TextDirection.ltr,
            child: Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      icon: Icon(Icons.location_city, color: Colors.white),
                      hintText: (lang == 'fa')
                          ? 'شهر مورد نظرتان را وارد کنید'
                          : 'Enter City Name',
                      hintStyle: TextStyle(color: Colors.grey, fontFamily: (lang == 'fa')?'vazir':'Spartan MB'),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)))),
                  onChanged: (value) {
                    city = value;
                  },
                ),
              ),

          ),
              ArgonButton(
                height: 50,
                roundLoadingShape: true,
                width: MediaQuery.of(context).size.width * 0.45,
                onTap:
                    (startLoading, stopLoading, btnState) async {
                  if (btnState == ButtonState.Idle) {
                    var ran = Random().nextInt(3);
                    if (ran == 1) {
                    }
                    Navigator.pop(context, city);
                  }
                },
                child: Text(
                  (lang == 'fa')
                      ? 'انتخاب شهر' : 'Get Weather',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: (lang == 'fa')
                          ? 'vazir'
                          : 'Spartan MB'),
                ),

                borderRadius: 5.0,
                color: Colors.white38,
              ),

            ],
          ),
        ),
      ),
    );
  }



}
