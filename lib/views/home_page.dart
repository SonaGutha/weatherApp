// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mp5/views/choose_location_page.dart';
import 'package:mp5/views/current_location_page.dart';
import 'package:mp5/views/favorite_location_page.dart';

class HomePage extends StatefulWidget {
  String city;
  HomePage({super.key, required this.city});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = CurrentLocationPage(
            city: widget
                .city); // takes the current location and displays the weather informantion
      case 1:
        page =
            const ChooseLocationPage(); // user can choose different cities to look for weather information by marking the city as favorite
      case 2:
        page =
            const FavoriteLocationPage(); // shows the list of favoite cities which on click will show the weather information

        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("Weather App"),
          centerTitle: true,
        ),
        body: Stack(children: [
          Image.asset(
            'assets/images/weather.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NavigationRail(
                //provides option to navigate between 3 different pages on selection
                extended: false,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.location_city),
                    label: Text('Choose Location'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favorites'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
                labelType: NavigationRailLabelType.selected,
              ),
              Expanded(
                child: Container(
                  child: page,
                ),
              ),
            ],
          )
        ]));
  }
}
