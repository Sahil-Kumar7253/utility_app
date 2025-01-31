import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:utility_app/features/weather/service/Weather_Service.dart';

import 'model/weathr_model.dart';

class WeatherPage extends StatefulWidget{
    const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPage ();
}

class _WeatherPage extends State<WeatherPage> {

  final _WeatherService = WeatherService("e0c65fe07b01b921f67df97809d4c355");

  Weather? _weather;

  _fetchWeather() async{
    String cityName = await _WeatherService.getCurrentCity();

    try{
      final weather = await _WeatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }catch(e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  String getWeatherIcon(String? mainCondition){
    if(mainCondition == null ){
      return 'assets/sunny_animation.json';
    }
    switch(mainCondition.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      case 'clear':
        return 'assets/sunny_animation.json';

      default :
        return 'assets/sunny_animation.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3694E1),
      body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                _weather?.cityName ?? 'Loading...',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),

            ),

            Lottie.asset(getWeatherIcon(_weather?.mainCondition)),

            Text(
              "${_weather?.temp.round().toString()}℃ ",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          ],)
        ),
    );
  }

}



