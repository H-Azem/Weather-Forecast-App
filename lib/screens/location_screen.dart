import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:tapsell_plus/tapsell_plus.dart';
import 'package:worldweather/services/weather.dart';
import 'package:worldweather/utilities/constants.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import '../Constant.dart';
import 'about.dart';
import 'city_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'dForecast.dart';
import 'hForecast.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.locData);
  final locData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var temp;
  var minTemp;
  var maxTemp;
  var condition;
  var clouds;
  var wind;
  var icon;
  var lon;
  var lat;
  String lang = window.locale.languageCode;
  var city;
  var main;
  var outCome;
  var description;
  var humidity;
  static DateTime now = DateTime.now();
  static var h = double.parse(intl.DateFormat('kk').format(now));
  //var nine = Random().nextInt(20);
  WeatherModel weather = WeatherModel();
  var iName;
  var qFa = [
    '"همه رویاهای ما میتوانند به حقیقت تبدیل شوند، اگر ما شجاعت دنبال کردن آنها را داشته باشیم" - والت دیزنی',
    '" -راز پیشرفت شروع کردن است" - مارک تواین',
    '"بهترین زمان برای کاشت درخت 20 سال پیش بود. اما زمان حال هم میتواند بهترین زمان باشد"- ضرب المثل چینی',
    '"اگر توقع داشتن یک روز خوب را داشته باشیم معمولا روز خوبی خواهیم داشت". - کاترین پول سیفیر',
    '"میتوانید تلاش کنید و یا حسرت بخورید، این انتخاب شماست "- ناشناس',
    '"اگر صدایی از درون به شما گفت شما نمیتوانید نقاشی کنید، هرطور که شده نقاشی کنید، آن صدا ساکت خواهد شد" - ونسان ون گوگ',
    '" .برخی از مردم میخواهند چیزی اتفاق بیفتد، برخی آرزو می کنند که اتفاق بیفتد، بعضی هم آن را انجام می دهند". مایکل جردن',
    '"کارهای بزرگ از طریق مجموعهای از کارهای کوچک عملی میشوند" – ونسان ون گوگ',
    '"اغلب اوقات تغییر خودمان از تغییر شرایط ضروریتر است"- آرتور کریتوفر بنسن',
    '"سخت کار کردن استعداد را شکست میدهد زمانی که استعداد سخت کار نمی کند " - تیم نوتکه',
    '"اکثر مردم فرصتها را از دست میدهند ؛ زیرا فرصتها در پوشش سختی ظاهر میشوند" - توماس ادیسون',
    '"رویاها به جایی نمیرسند مگر اینکه آنها را محقق کنید" – جان. سی. ماکسول',
    '"اگر میخواهید پرواز کنید، هر چیزی که شما را به پایین میکشد را رها کنید" – بودا',
    '" .یک مایل بیشتر برو.آنجا هرگز شلوغ نیست. "- دکتر وین دی. دایر',
    '" .من هرگز بازنده نمیشوم، من یا پیروز میشوم یا یاد میگیرم. "- نلسون ماندا',
    '"لازم نیست کل پله ها را ببینید، فقط کافی است اولین قدم را بردارید" – مارتین لوتر کینگ',
    '"از آنچه که در اختیار دارید خوشنود باشید درحالیکه برای چیزی که میخواهید تلاش می کنید" - هلن کلر',
    '.برنامه های خود را به دیگران نگویید، بلکه آنها را نشان دهید',
    '"آنقدر خوب باشید، که نتوانند شما را نادیده بگیرند" - استیو مارتین',
    '" .دیروز زیرک بودم، بنابراین میخواستم جهان را تغییر دهم. امروز خردمند هستم، بنابراین میخواهم خودم را تغییر دهم. "- مولوی',
    '" .هیچ کس تا به حال نتوانسته با شبیه دیگران بودن تفاوتی ایجاد کند."',
    '" .لازم نیست ساعت را تماشا کنید؛ کافی است کاری که انجام میدهد را انجام دهید. ادامه دهید"- سام لونسون',
    '"تغییر با کاری که به طور مرتب انجام می دهید ایجاد خواهد شد نه کاری که هر از چند گاهی یک بار انجام می دهید - جنی کریگ',
    '"از نظر من تلویزیون بسیار آموزنده است. هر بار که کسی آن را روشن می کند، من به اتاق دیگری می روم و کتاب می خوانم. "- گروچو مارکس',
    '" .بزرگترین افتخار ما شکست نخوردن نیست، بلکه توانایی بلند شدن بعد از هر شکست است" – کنفوسیوس',
    '" .هنگامی که در مورد زندگی فکر می کنید، به یاد داشته باشید: احساس گناه نمیتواند گذشته را تغییر دهد و نگرانی آینده را تغییر نخواهد داد"',
    '"ذهن منفی هرگز یک زندگی مثبت ایجاد نمیکند"',
    '"یک چیز قطعی است، اگر بازی نکنید، برنده نخواهید شد" - کایلی فرانسیس',
    'همان تغییری باشید که میخواهید در جهان ببینید.',
    '"زمان شما محدود است پس آن را با زندگی به جای دیگران هدر ندهید." - استیو جابز',
    '"وقتی برنده یا بازنده می شوم، مسئولیت آن را میپذیرم، زیرا من واقعا برای کاری که میکنم مسئول هستم" – نیکی میناژ',
    '" .من هرگز بازنده نمیشوم، من یا پیروز میشوم یا یاد میگیرم. "- نلسون ماندا',
  ];
  var qEn = [
    '“All our dreams can come true, if we have the courage to pursue them.” – Walt Disney',
    '“The secret of getting ahead is getting started.” – Mark Twain',
    '“The best time to plant a tree was 20 years ago. The second best time is now.” – Chinese Proverb',
    '“If we have the attitude that it’s going to be a great day it usually is.” – Catherine Pulsifier',
    '“You can either experience the pain of discipline or the pain of regret. The choice is yours.” – Unknown',
    '“If you hear a voice within you say ‘you cannot paint,’ then by all means paint and that voice will be silenced.” – Vincent Van Gogh',
    '“Some people want it to happen, some wish it would happen, others make it happen.” – Michael Jordan',
    '“Great things are done by a series of small things brought together” – Vincent Van Gogh',
    '“Very often, a change of self is needed more than a change of scene.’ – A.C. Benson',
    '“Hard work beats talent when talent doesn’t work hard.” – Tim Notke',
    '“Opportunity is missed by most people because it is dressed in overalls and looks like work.” – Thomas Edison',
    '“Dreams don’t work unless you do.” – John C. Maxwell',
    '“If you want to fly give up everything that weighs you down.” – Buddha',
    '“Go the extra mile. It’s never crowded there.” – Dr. Wayne D. Dyer',
    '“I never lose. Either I win or learn.” – Nelson Mandela',
    '“You don’t need to see the whole staircase, just take the first step.” – Martin Luther King Jr.',
    '“Be happy with what you have while working for what you want.” – Helen Keller',
    'Don’t tell everyone your plans, instead show them your results.',
    '“Be so good they can’t ignore you.” – Steve Martin',
    '“Yesterday I was clever, so I wanted to change the world. Today I am wise, so I am changing myself.” – Rumi',
    '“No one has ever made a difference by being like everyone else.” – The Greatest Showman',
    '“Don’t watch the clock; do what it does. Keep going.” – Sam Levenso',
    '“It’s not what you do once in a while it’s what you do day in and day out that makes the difference.” – Jenny Craig',
    '“I find television very educational. Every time someone turns it on, I go in the other room and read a book.’ – Groucho Marx',
    '“Our greatest glory is not in never falling, but in rising every time we fall.” – Confucius',
    '“When thinking about life, remember this: no amount of guilt can change the past and no amount of anxiety can change the future.”',
    '“A negative mind will never give you a positive life.”',
    '“One thing’s for sure, if you don’t play, you don’t win.” – Kylie Francis',
    'Be the change you want to see in the world.',
    '“Your time is limited, so don’t waste it living someone else’s life.” ― Steve Jobs',
    '“When I win and when I lose, I take ownership of it, because I really am in charge of what I do.” – Nicki Minaj',
    '“I never lose. Either I win or learn.” – Nelson Mandela',
  ];

  @override
  void initState() {
    super.initState();
    UpdateScreen(widget.locData);
    requestRewardedVideo();
  }

  void UpdateScreen(dynamic data) {
    setState(() {
      if (data == null) {
        InfoBgAlertBox(
            context: context,
            infoMessage: (lang == 'fa')
                ? 'شهر مورد نظرتون پیدا نشد. بررسی کنید اشتباه تایپی نداشته باشید!'
                : 'The city you want was not found!!!',
            buttonText: (lang == 'fa') ? 'باشه' : 'Ok');
      }

      temp = data['main']['temp'].toInt();
      minTemp = data['main']['temp_min'].toInt();
      maxTemp = data['main']['temp_max'].toInt();
      lon = data['coord']['lon'];
      lat = data['coord']['lat'];
      humidity = data['main']['humidity'].toInt();
      wind = data['wind']['speed'];
      clouds = data['clouds']['all'];
      condition = data['weather'][0]['id'];
      main = data['weather'][0]['main'];
      icon = data['weather'][0]['icon'];
      city = data['name'];
      description = data['weather'][0]['description'];
      outCome = weather.getMessage(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

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
    showRewardedVideo();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/$iName.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var locData = await WeatherModel().getLoc();
                      UpdateScreen(locData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ArgonButton(
                      height: 50,
                      roundLoadingShape: true,
                      width: MediaQuery.of(context).size.width * 0.45,
                      onTap: (startLoading, stopLoading, btnState) async {
                        if (btnState == ButtonState.Idle) {
                          var cityName = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CityScreen();
                          }));
                          if (cityName != null) {
                            var loData =
                                await WeatherModel().getCity(cityName);
                            UpdateScreen(loData);
                          }
                        }
                      },
                      child: Text(
                        (lang == 'fa') ? 'تغییر شهر' : 'Change City',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                (lang == 'fa') ? 'vazir' : 'Spartan MB'),
                      ),
                      borderRadius: 100.0,
                      color: Colors.black12,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Container(child: Image.asset('images/Icons/$icon.png'))
                  ],
                ),
              ),
              Directionality(
                textDirection:
                    (lang == 'fa') ? TextDirection.rtl : TextDirection.ltr,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Text(
                    (lang == 'fa')
                        ? "$city\n$description\nکمینه دما= $minTemp درجه\nبیشینه دما= $maxTemp درجه\nرطوبت= ${humidity.toString() + "درصد "}\nسرعت باد= ${(wind.toInt()).toString()} متر بر ثانیه\nپوشش ابر= ${clouds.toString() + "درصد "}"
                        : "$city\n$description\nMin= $minTemp°\nMax=$maxTemp°\nHumidity= %$humidity\nWind= $wind m/s\nCloads= %$clouds",
                    textAlign:
                        (lang == 'fa') ? TextAlign.right : TextAlign.left,
                    style: (lang == 'fa')
                        ? faMessageTextStyle
                        : kMessageTextStyle,
                  ),
                ),
              ),
              Directionality(
                textDirection:
                    (lang == 'fa') ? TextDirection.rtl : TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Directionality(
                        textDirection: (lang == 'fa')
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        child: ArgonButton(
                          height: 50,
                          roundLoadingShape: true,
                          width: MediaQuery.of(context).size.width * 0.45,
                          onTap: (startLoading, stopLoading, btnState) async {
                            if (btnState == ButtonState.Idle) {
                              startLoading();

                              var Data =
                                  await WeatherModel().getForecast(lon, lat);

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return dForecast(Data);
                              }));
                              stopLoading();
                              requestRewardedVideo();
                              showRewardedVideo();

                            } else {
                              requestRewardedVideo();

                              stopLoading();
                              showRewardedVideo();

                            }
                          },
                          child: Text(
                            (lang == 'fa')
                                ? "هفت روز آینده"
                                : '7 Days Forecast',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontFamily:
                                    (lang == 'fa') ? 'vazir' : 'Spartan MB'),
                          ),
                          loader: Container(
                            padding: EdgeInsets.all(10),
                            child: SpinKitRotatingCircle(
                              color: Colors.blueAccent,
                              // size: loaderWidth ,
                            ),
                          ),
                          borderRadius: 5.0,
                          color: Colors.white70,
                        ),
                      ),
                      ArgonButton(
                        height: 50,
                        roundLoadingShape: true,
                        width: MediaQuery.of(context).size.width * 0.45,
                        onTap: (startLoading, stopLoading, btnState) async {
                          if (btnState == ButtonState.Idle) {
                            startLoading();

                            var Data =
                                await WeatherModel().getForecast(lon, lat);

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return hForecast(Data);
                            }));
                            stopLoading();
                            requestRewardedVideo();

                            showRewardedVideo();

                          } else {
                            stopLoading();
                            requestRewardedVideo();

                            showRewardedVideo();

                          }
                        },
                        child: Text(
                          (lang == 'fa')
                              ? "12 ساعت آینده"
                              : '12 Hour Forecast',
                          textAlign: (lang == 'fa')
                              ? TextAlign.right
                              : TextAlign.left,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily:
                                  (lang == 'fa') ? 'vazir' : 'Spartan MB'),
                        ),
                        loader: Container(
                          padding: EdgeInsets.all(10),
                          child: SpinKitRotatingCircle(
                            color: Colors.blueAccent,
                            // size: loaderWidth ,
                          ),
                        ),
                        borderRadius: 5.0,
                        color: Colors.white70,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Directionality(
                    textDirection: (lang == 'fa')
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child: Card(
                      color: Colors.white70,
                      margin: EdgeInsets.fromLTRB(10, 3, 10, 2),
                      child: ListTile(
                        title: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.format_quote,
                                    color: Colors.blueAccent),
                                Text(
                                  (lang == 'fa')
                                      ? "سخن روز:"
                                      : 'Quote of the Day:',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: (lang == 'fa')
                                          ? 'vazir'
                                          : 'Spartan MB'),
                                ),
                              ],
                            ),
                            Text(
                              (lang == 'fa') ? qFa[now.day] : qEn[now.day],
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: (lang == 'fa')
                                      ? 'vazir'
                                      : 'Spartan MB'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ArgonButton(
                  height: 50,
                  roundLoadingShape: true,
                  width: MediaQuery.of(context).size.width * 0.45,
                  onTap: (startLoading, stopLoading, btnState) async {
                    if (btnState == ButtonState.Idle) {
                     await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return about();
                      }));

                    }
                  },
                  child: Text(
                    (lang == 'fa') ? 'درباره' : 'Resources',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: (lang == 'fa') ? 'vazir' : 'Spartan MB'),
                  ),
                  borderRadius: 100.0,
                  color: Colors.black12,
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
  void requestRewardedVideo() {
    TapsellPlus.requestRewardedVideo(
        Constant.TAPSELL_REWARDED_VIDEO,
            (zoneId) => response(zoneId),
            (zoneId, errorMessage) => error(zoneId, errorMessage));
  }

  void showRewardedVideo() {
    TapsellPlus.showAd(Constant.TAPSELL_REWARDED_VIDEO,
        opened: (zoneId) => opened(zoneId),
        closed: (zoneId) => closed(zoneId),
        rewarded: (zoneId) => rewarded(zoneId),
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

  rewarded(zoneId) {
    print("rewarded: zone_id = $zoneId");
  }
}



