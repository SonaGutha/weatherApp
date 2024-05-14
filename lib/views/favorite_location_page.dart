import 'package:flutter/material.dart';
import 'package:mp5/views/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteLocationPage extends StatefulWidget {
  const FavoriteLocationPage({super.key});
  @override
  State<FavoriteLocationPage> createState() => _FavoriteLocationPageState();
}

class _FavoriteLocationPageState extends State<FavoriteLocationPage> {
  List<String> favoriteLocations = [];
  @override
  void initState() {
    super.initState();
    _loadFavoriteLocations();
  }

  //load the favorite cities from the shared preferences
  Future<void> _loadFavoriteLocations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favCities = prefs.getStringList('favorite_cities') ?? [];
    setState(() {
      favoriteLocations = favCities;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (favoriteLocations.isEmpty) {
      return const Center(
        child: Text(
          'No favorite location yet', //default message when no favorite location is selectec
          style: TextStyle(fontSize: 22),
        ),
      );
    }
    return ListView.builder(
      itemCount: favoriteLocations.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(favoriteLocations[index],
              style: const TextStyle(fontSize: 22)),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                    city: favoriteLocations[
                        index]), //on tap of the location, navigates to a page to show weather information
              ),
            );
          },
        );
      },
    );
  }
}
