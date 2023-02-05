import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp_starter_project/models/constants.dart';

class Detailpage extends StatefulWidget {
  final dailyForecastWeather;

  const Detailpage({Key? key, this.dailyForecastWeather}) : super(key: key);

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  final Constants _myConstants = Constants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var weatherData = widget.dailyForecastWeather;

    //function to get weather data
    Map getWeatherForecast(int index) {
      int maxWindSpeed = weatherData[index]["day"]["maxwind_kph"].intInt();
      int avgHumidity = weatherData[index]["day"]["avghumidity"].intInt();
      int chanceOfRain =
          weatherData[index]["day"]["daily_chance_of_rain"].intInt();

      var parsedDate = DateTime.parse(weatherData[index]["date"]);
      var forecastDate = DateFormat('EEEE, d MMMM').format(parsedDate);

      String weatherName = weatherData[index]["day"]["condition"]["text"];
      String weatherIcon =
          weatherName.replaceAll(' ', '').toLowerCase() + ".png";

      int minTemprature = weatherData[index]["day"]["mintemp_c"].toInt();
      int maxTemprature = weatherData[index]["day"]["maxtemp_c"].toInt();

      var forecastData = {
        'maxWindSpeed': maxWindSpeed,
        'avgHumidity': avgHumidity,
        'chanceOfRain': chanceOfRain,
        'forecastDate': forecastDate,
        'weatherName': weatherName,
        'weatherIcon': weatherIcon,
        'minTemprature': minTemprature,
        'maxTemprature': maxTemprature,
      };

      return forecastData;
    }

    return Scaffold(
      backgroundColor: _myConstants.primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Forercast'),
        backgroundColor: _myConstants.primaryColor,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child:
                IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: size.height * .75,
              width: size.width,
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                color: Colors.white,
                // ignore: prefer_const_constructors
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(50),
                  topRight: const Radius.circular(50),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    right: 20,
                    left: 20,
                    child: Container(
                      height: size.height * 0.44,
                      width: size.width * .7,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.center,
                              colors: [
                                Color(0xffa9c1f5),
                                Color(0xff6696f5),
                              ]),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.1),
                              offset: const Offset(0, 25),
                              blurRadius: 3,
                              spreadRadius: -10,
                            )
                          ]),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            child: Image.asset(
                              "assets/" + getWeatherForecast(0)["weatherIcon"],
                              width: 50,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
