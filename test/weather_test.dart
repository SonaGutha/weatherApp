import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/weather.dart';

void main() {
  group('Weather', () {
    test(
        'fromJson which creates a weather instance from JSON data fetched from api response',
        () {
      Map<String, dynamic> jsonData = {
        'name': 'Chicago',
        'main': {'temp': 52.18, 'humidity': 50, 'feels_like': 53.18},
        'weather': [
          {'main': 'cloudy', 'description': 'overcast clouds'}
        ]
      };

      Weather weather = Weather.fromJson(jsonData);

      expect(weather.city, 'Chicago');
      expect(weather.currenttemp, 52.18);
      expect(weather.humidity, 50);
      expect(weather.feelslike, 53.18);
      expect(weather.description, 'overcast clouds');
      expect(weather.condition, 'cloudy');
    });

    test('fromJson should handle missing or incorrect main JSON data', () {
      Map<String, dynamic> incompleteData = {
        'name': 'Chicago',
        'main': {'humidity': 50, 'feels_like': 28.0},
        'weather': [
          {'main': 'cloudy', 'description': 'overcast clouds'}
        ]
      };
      Weather weather = Weather.fromJson(incompleteData);
      expect(weather.city, 'Chicago');
      expect(weather.currenttemp, 0.0);
      expect(weather.humidity, 50);
      expect(weather.feelslike, 28.0);
      expect(weather.description, 'overcast clouds');
      expect(weather.condition, 'cloudy');
    });

    test('fromJson when JSON main data is empty', () {
      Map<String, dynamic> emptyMainData = {
        'name': 'Chicago',
        'main': {},
        'weather': [
          {'main': 'cloudy', 'description': 'overcast clouds'}
        ]
      };
      Weather weather = Weather.fromJson(emptyMainData);
      expect(weather.city, 'Chicago');
      expect(weather.currenttemp, 0.0);
      expect(weather.humidity, 0);
      expect(weather.feelslike, 0.0);
      expect(weather.description, 'overcast clouds');
      expect(weather.condition, 'cloudy');
    });

    test('fromJson should handle missing or incorrect weather JSON data', () {
      Map<String, dynamic> incompleteWeatherData = {
        'name': 'Chicago',
        'main': {'temp': 52.18, 'humidity': 50, 'feels_like': 28.0},
        'weather': [
          {'main': 'cloudy'}
        ]
      };
      Weather weather = Weather.fromJson(incompleteWeatherData);
      expect(weather.city, 'Chicago');
      expect(weather.currenttemp, 52.18);
      expect(weather.humidity, 50);
      expect(weather.feelslike, 28.0);
      expect(weather.description, '');
      expect(weather.condition, 'cloudy');
    });

    test('fromJson should handle empty weather JSON data', () {
      Map<String, dynamic> emptyWeatherData = {
        'name': 'Chicago',
        'main': {'temp': 52.18, 'humidity': 50, 'feels_like': 28.0},
        'weather': [{}]
      };
      Weather weather = Weather.fromJson(emptyWeatherData);
      expect(weather.city, 'Chicago');
      expect(weather.currenttemp, 52.18);
      expect(weather.humidity, 50);
      expect(weather.feelslike, 28.0);
      expect(weather.description, '');
      expect(weather.condition, '');
    });
  });
}
