import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/weather.dart';

class CurrentLocationPage extends StatefulWidget {
  final String baseurl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey = '';
  final String city;

  const CurrentLocationPage({super.key, required this.city});
  @override
  State<CurrentLocationPage> createState() => _CurrentLocationPageState();
}

class _CurrentLocationPageState extends State<CurrentLocationPage> {
  var selectedIndex = 0;

  Weather? weather;
  @override
  void initState() {
    super.initState();
    _loaddata();
  }

  //Fetch weather data
  Future<Weather> fetchWeatherData(String cityName) async {
    final response = await http.get(Uri.parse(
        '${widget.baseurl}?q=$cityName&APPID=${widget.apiKey}&units=imperial'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch app data");
    }
  }

  // Fetch current location when user allows location access
  Future<String?> fetchCurrentLocation() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      return placemarks.first.locality;
    }
    return '';
  }

  // The location fetched is used to get weather data or the selected favorite location is used to
  //get weather data
  _loaddata() async {
    String city =
        widget.city == '' ? await fetchCurrentLocation() ?? '' : widget.city;

    final weatherdata = await fetchWeatherData(city);
    setState(() {
      weather = weatherdata;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Image.asset(
        'assets/images/weather.png',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              weather?.city ?? "",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[900]),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Temperature : ${weather?.currenttemp.toString()} \u00B0F',
              style: const TextStyle(fontSize: 24),
            ),
            Text('Feels Like: ${weather?.feelslike.toString()} \u00B0F',
                style: const TextStyle(fontSize: 20)),
            Text('Humidity: ${weather?.humidity.toString()}',
                style: const TextStyle(fontSize: 18)),
            Text('Weather Conditon: ${weather?.condition.toString()}',
                style: const TextStyle(fontSize: 18))
          ],
        ),
      )
    ]));
  }
}
