import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseLocationPage extends StatefulWidget {
  const ChooseLocationPage({super.key});
  @override
  State<ChooseLocationPage> createState() => _ChooseLocationPageState();
}

class _ChooseLocationPageState extends State<ChooseLocationPage> {
  List<String> togglefav = [];
  static const List<String> cities = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
    'Phoenix',
    'Philadelphia',
    'San Antonio',
    'San Diego',
    'Dallas',
    'San Jose',
    'Austin',
    'Jacksonville',
    'San Francisco',
    'Indianapolis',
    'Columbus',
    'Fort Worth',
    'Charlotte',
    'Seattle',
    'Denver',
    'El Paso',
    'Detroit',
    'Washington',
    'Boston',
    'Memphis',
    'Nashville',
    'Portland',
    'Oklahoma City',
    'Las Vegas',
    'Baltimore',
    'Louisville',
    'Milwaukee',
    'Albuquerque',
    'Tucson',
    'Fresno',
    'Sacramento',
    'Kansas City',
    'Long Beach',
    'Mesa',
    'Atlanta',
    'Colorado Springs',
    'Virginia Beach',
    'Raleigh',
    'Omaha',
    'Miami',
    'Oakland',
    'Minneapolis',
    'Tulsa',
    'Wichita'
  ];

  List<String> shuffleCities = [];

  @override
  void initState() {
    super.initState();
    shuffleCities = List.from(cities)
      ..shuffle(); //displays the list of cities in random order
    _loadFavoriteCities();
  }

  //loads favorite city from the shared preferences
  Future<void> _loadFavoriteCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteCities = prefs.getStringList('favorite_cities') ?? [];
    setState(() {
      togglefav = favoriteCities;
    });
  }

  //toggles between favorite cities and stores the favorite cities in the shared preferences
  Future<void> _toggleFavorite(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteCities = prefs.getStringList('favorite_cities') ?? [];

    if (favoriteCities.contains(city)) {
      favoriteCities.remove(city);
    } else {
      favoriteCities.add(city);
    }

    prefs.setStringList('favorite_cities', favoriteCities);
    _loadFavoriteCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      ListView.builder(
        itemCount: shuffleCities.length,
        itemBuilder: (context, index) {
          final String currentCity = shuffleCities[index];
          final bool isFavorite = togglefav.contains(currentCity);
          return ListTile(
              title: Text(
                currentCity,
                style: TextStyle(fontSize: 22, color: Colors.blueGrey[900]),
              ),
              trailing: IconButton(
                icon: Icon(
                  isFavorite
                      ? Icons.favorite
                      : Icons
                          .favorite_border, //Mark or remove the location as favorite
                  color: Colors.pink[300],
                ),
                onPressed: () {
                  _toggleFavorite(shuffleCities[index]);
                },
              ));
        },
      )
    ]));
  }
}
