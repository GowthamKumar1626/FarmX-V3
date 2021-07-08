import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:farmx/Screens/Weather.dart';
import 'package:farmx/Screens/WeatherDetailsScreen.dart';
import 'package:farmx/Screens/weather/models/location.dart';
import 'package:farmx/Services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({Key? key}) : super(key: key);
  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  List<Location> locations = [
    new Location(
        city: city1, country: "India", lat: "78.9629°", lon: "20.5937°")
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              fullscreenDialog: true,
              builder: (context) => WeatherDetailsScreen(locations, context),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(5.0),
          height: MediaQuery.of(context).size.height * 0.16,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image(
                  image: AssetImage("assets/icons/weatherblack.png"),
                  width: 100,
                  height: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: FutureBuilder(
                  future: getCurrentWeather(context),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Weather? _weather = snapshot.data as Weather?;
                      if (_weather == null) {
                        return Text("Error in Connecting :( !");
                      } else {
                        return weatherBox(_weather, context);
                      }
                    } else {
                      return Container(
                        child: CircularProgressIndicator(
                          color: Colors.indigo,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget weatherBox(Weather _weather, BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(10),
          child: Text(
            "${_weather.temp}°C",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: MediaQuery.of(context).size.width * 0.08,
              color: Colors.black,
            ),
          ),
        ),
        Text(
          "${_weather.description[0].toUpperCase()}${_weather.description.substring(1)}",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: MediaQuery.of(context).size.width * 0.04,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

String city1 = "Vijayawada";
Future getCurrentWeather(BuildContext context) async {
  final location = Provider.of<LocationService>(context, listen: false);
  Weather? weather;
  String city = await location.locationName();
  city1 = city;
  String apiKey = "7e8d6cea22d980cbea8835e0f093ab28";
  var url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric");

  final response = await http.get(url);
  if (response.statusCode == 200) {
    weather = Weather.fromJson(jsonDecode(response.body));
  } else {}

  return weather;
}

Widget generateBlurredImage() {
  return new Container(
    decoration: new BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage('assets/images/huxley-lsd.png'),
        fit: BoxFit.cover,
      ),
    ),
    child: new BackdropFilter(
      filter: new ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
      child: new Container(
        //you can change opacity with color here(I used black) for background.
        decoration: new BoxDecoration(color: Colors.black.withOpacity(0.2)),
      ),
    ),
  );
}
