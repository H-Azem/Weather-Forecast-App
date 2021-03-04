import 'dart:ui';

import 'package:worldweather/services/location.dart';
import 'package:worldweather/services/networking.dart';



class WeatherModel {

  static const appId = '4750f6c73ccb9220892469b39a1eb96f';
  var longitude;
  var latitude;
  String lang =window.locale.languageCode;

  Future<dynamic> getCity(String city) async {

    networking CNet = networking(
        (lang == 'fa')?'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$appId&lang=fa&units=metric':'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$appId&units=metric');
    var cityResult = await CNet.GetData();
    print(cityResult);
    return cityResult;
  }

  Future<dynamic> getLoc() async {
    location Loc = location();
    await Loc.GetLocation();
    longitude = Loc.longitude;
    latitude = Loc.latitude;
    networking Net = networking(
        (lang == 'fa')?'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$appId&lang=fa&units=metric':'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$appId&units=metric');
    var outCome = await Net.GetData();
    return outCome;
  }

  Future<dynamic> getForecast(longitude,latitude) async {
    networking Net = networking(
        (lang == 'fa')? 'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=minutely&appid=$appId&lang=fa&units=metric':'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&exclude=minutely&appid=$appId&units=metric');
    var outCome = await Net.GetData();
    print(outCome);
    return outCome;
  }

  String getWeatherIcon(var condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(var temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
