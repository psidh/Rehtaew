import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(RehtaewApp());

class RehtaewApp extends StatefulWidget {
  @override
  _RehtaewAppState createState() => _RehtaewAppState();
}

class _RehtaewAppState extends State<RehtaewApp> {
  String city = '';
  String temp = '';
  String type = '';

  Future<void> fetchData(String city) async {
    final apiKey = 'YOUR_API_KEY';
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          temp = jsonData['main']['temp'].toString();
          type = jsonData['weather'][0]['description'];
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      print('Error fetching weather data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
          scrolledUnderElevation: 12.00,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter city name',
                  ),
                  onChanged: (text) {
                    city = text;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  fetchData(city);
                },
                child: Text('Get Weather'),
              ),
              SizedBox(height: 20),
              Text(
                'City: $city',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Temperature: $temp °C',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Description: $type',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
