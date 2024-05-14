class Weather {
  final double currenttemp;
  final String city;
  final int humidity;
  final double feelslike;
  final String condition;
  final String description;

  Weather(
      {required this.city,
      required this.description,
      required this.humidity,
      required this.feelslike,
      required this.currenttemp,
      required this.condition});

  // load data from the weather api json response
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        description: json['weather'][0]['description'] ?? '',
        currenttemp: json['main']['temp'] ?? 0.0,
        city: json['name'] as String,
        humidity: json['main']['humidity'] ?? 0,
        feelslike: json['main']['feels_like'] ?? 0.0,
        condition: json['weather'][0]['main'] ?? '');
  }
}
