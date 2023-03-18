import 'package:flutter/material.dart';

import 'weather.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  late Future<Weather> _futureWeather;

  @override
  void initState() {
    super.initState();
    _futureWeather =
        Weather.fetch('API', 37.7749, -122.4194); // TODO: Add API Key
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: Center(
          child: FutureBuilder<Weather>(
            future: _futureWeather,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final weather = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${weather.temperature}°C',
                      style: TextStyle(fontSize: 48),
                    ),
                    Image.network(weather.iconUrl),
                    Text(
                      weather.description,
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      weather.locationName,
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
